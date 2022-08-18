using Microsoft.EntityFrameworkCore;
using OnlineShoppingApi.Data;
using OnlineShoppingApi.Models;
using static OnlineShoppingApi.Common.Constants;

namespace OnlineShoppingApi.Service
{
    public class OrderService : IOrderService
    {
        private readonly OnlineShoppingContext _context;
        public OrderService(OnlineShoppingContext context)
        {
            _context = context;
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