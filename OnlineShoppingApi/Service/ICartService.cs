using OnlineShoppingApi.Models;

namespace OnlineShoppingApi.Service
{

    public interface ICartService
    {
        public (bool, string) AddToCart(Cart cart);
        IQueryable<Cart> GetCartDetails(string userId);
        bool RemoveFromCart(int productId, string userId);
    }

}