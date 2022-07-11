using Microsoft.EntityFrameworkCore;
using OnlineShoppingApi.Data;
using OnlineShoppingApi.Models;

namespace OnlineShoppingApi.Service
{
    public class CartService : ICartService
    {
        private readonly OnlineShoppingContext _context;
        public CartService(OnlineShoppingContext context)
        {
            _context = context;
        }

        public bool AddToCart(Cart cart)
        {
            _context.Carts.Add(cart);
            var result = _context.SaveChanges();
            return result > 0;
        }

        public IQueryable<Cart> GetCartDetails(string userId)
        {

            var productsInCart = _context.Carts.Where(x => x.UserId == userId && x.OrderId == null).Include(x => x.ProductDetail);
            return productsInCart;
        }

        public bool OrderProducts(Order orderDetails)
        {
            var productsInCart = _context.Carts.Where(x => x.UserId == orderDetails.UserId && x.OrderId == null).Include(x => x.ProductDetail).ToList();
            if (productsInCart == null || productsInCart.Count() == 0)
            {
                return false;
            }
            var orderTotal = productsInCart.Sum(x => x.ProductDetail.Price * x.Quantity);
            orderDetails.PaymentInfo.TotalAmount = orderTotal;
            orderDetails.OrderStatus = OrderStatus.Success;
            orderDetails.Addresses.First().AddressType = AddressType.ShippingAddress;
            orderDetails.Addresses.Last().AddressType = AddressType.BillingAddress;

            _context.Orders.Add(orderDetails);

            _context.SaveChanges();
            foreach (var product in productsInCart)
            {
                product.OrderId = orderDetails.OrderId;
            }
            _context.SaveChanges();

            return true;
        }

        public IQueryable<Order> GetAllOrders()
        {
            IQueryable<Order> orderList = _context.Orders.Include(x => x.Addresses).Include(x => x.PaymentInfo).Include(x => x.Products).ThenInclude(x => x.ProductDetail);
            return orderList;
        }

        public IQueryable<Order> GetOrderByUserId(string userId)
        {
            IQueryable<Order> orderList = _context.Orders.Where(x => x.UserId == userId).Include(x => x.Addresses).Include(x => x.PaymentInfo).Include(x => x.Products).ThenInclude(x => x.ProductDetail);
            return orderList;
        }
    }

}