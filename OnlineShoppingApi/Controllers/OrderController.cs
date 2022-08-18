using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using OnlineShoppingApi.Models;
using OnlineShoppingApi.Service;

namespace OnlineShoppingApi.Controllers
{

    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class OrderController : ControllerBase
    {

        private readonly ILogger<OrderController> _logger;
        private readonly IOrderService _orderService;

        public OrderController(ILogger<OrderController> logger, IOrderService orderService)
        {
            _logger = logger;
            _orderService = orderService;
        }
        [HttpGet]
        public IActionResult MyOrders()
        {
            string userId = User?.Claims?.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
            _logger.LogInformation("Fetching Order Details..");
            var orderList = _orderService.GetOrderByUserId(userId);
            _logger.LogInformation("Fetched Order Details successfully!");

            if (orderList == null || orderList.Count() == 0)
            {
                _logger.LogInformation("No order placed so far");

                return NotFound("No orders placed yet!!");
            }

            _logger.LogInformation($"{orderList.Count()} Order found");
            return Ok(orderList);
        }

        [HttpPost]
        public IActionResult PlaceOrder(Order order)
        {
            string userId = User?.Claims?.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
            order.UserId = userId;

            _logger.LogInformation("Placing order...");
            var result = _orderService.OrderProducts(order);
            if (!result)
            {
                _logger.LogInformation("Failed to place order");
                return StatusCode(StatusCodes.Status500InternalServerError, "Can't Place order, Your cart is empty. Please add items to cart first then Place your order.");
            }
            _logger.LogInformation("Order placed sucessfully!");
            return CreatedAtAction(nameof(MyOrders), "Order Placed succesfully!!");

        }

        // [HttpGet()]
        // public IActionResult GetAllOrders()
        // {
        //     _logger.LogInformation("Fetching all placed orders...");
        //     var orderList = _orderService.GetAllOrders();
        //     _logger.LogInformation("Order details fetched sucessfully");
        //     if (orderList == null || orderList.Count() == 0)
        //     {
        //         _logger.LogInformation("No order found");
        //         return NotFound("No Order Placed by any User");
        //     }
        //     _logger.LogInformation($"{orderList.Count()} orders found");
        //     return Ok(orderList);
        // }
    }
}