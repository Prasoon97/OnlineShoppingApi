using OnlineShoppingApi.Models;

namespace OnlineShoppingApi.Service
{
    public interface IOrderService
    {
        bool OrderProducts(Order orderDetails);
        IQueryable<Order> GetAllOrders();
        IQueryable<Order> GetOrderByUserId(string userId);
    }
}