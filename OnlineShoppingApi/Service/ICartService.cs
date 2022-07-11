using OnlineShoppingApi.Models;

namespace OnlineShoppingApi.Service
{

    public interface ICartService
    {
        bool AddToCart(Cart cart);
        IQueryable<Cart> GetCartDetails(string userId);
        bool OrderProducts(Order orderDetails);
        IQueryable<Order> GetAllOrders();
        IQueryable<Order> GetOrderByUserId(string userId);
    }

}