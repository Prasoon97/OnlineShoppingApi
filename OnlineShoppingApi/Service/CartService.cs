using Microsoft.EntityFrameworkCore;
using OnlineShoppingApi.Data;
using OnlineShoppingApi.Models;
using static OnlineShoppingApi.Common.Constants;

namespace OnlineShoppingApi.Service
{
    public class CartService : ICartService
    {
        private readonly OnlineShoppingContext _context;
        public CartService(OnlineShoppingContext context)
        {
            _context = context;
        }

        public (bool, string) AddToCart(Cart cart)
        {
            var result = ValidateCart(cart);
            if (!result.Item1)
            {
                return result;
            }
            else
            {
                var productInCart = _context.Carts.FirstOrDefault(c => c.UserId == cart.UserId && c.ProductId == cart.ProductId & c.OrderId == null);
                if (productInCart != null)
                {
                    productInCart.Quantity += cart.Quantity;
                }
                else
                {
                    _context.Carts.Add(cart);
                }
                _context.SaveChanges();
                return (true, "Success");
            }
        }

        public IQueryable<Cart> GetCartDetails(string userId)
        {

            var productsInCart = _context.Carts.Where(x => x.UserId == userId && x.OrderId == null).Include(x => x.ProductDetail);
            return productsInCart;
        }

        public bool RemoveFromCart(int productId, string userId)
        {
            var productsInCart = _context.Carts.FirstOrDefault(c => c.UserId == userId && c.OrderId == null && c.ProductId == productId);
            if (productsInCart != null)
            {
                _context.Carts.Remove(productsInCart);
                _context.SaveChanges();
                return true;
            }
            return false;
        }

        private (bool, string) ValidateCart(Cart cart)
        {
            bool isValid;
            string message;
            var productInCart = _context.Carts.FirstOrDefault(c => c.UserId == cart.UserId && c.ProductId == cart.ProductId & c.OrderId == null);
            int totalCartQuantity = cart.Quantity + (productInCart == null ? 0 : productInCart.Quantity);
            var product = _context.Products.FirstOrDefault(p => p.Id == cart.ProductId);
            if (product == null)
            {
                isValid = false;
                message = "Product does not exist";
            }
            else if (product.MinOrder != null && totalCartQuantity < product.MinOrder)
            {
                isValid = false;
                message = $"Please provide a correct Quantity, Minimum order quantity for this product is {product.MinOrder}";
            }
            else if (product.MaxOrder != null && totalCartQuantity > product.MaxOrder)
            {
                isValid = false;
                message = $"Please provide a correct Quantity, Maximum order quantity for this product is {product.MaxOrder}";
            }
            else
            {
                isValid = true;
                message = "Success";
            }

            return (isValid, message);
        }

    }

}