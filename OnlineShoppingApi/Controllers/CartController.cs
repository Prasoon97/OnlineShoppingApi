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
    public class CartController : ControllerBase
    {
        private readonly ILogger<CartController> _logger;
        private readonly ICartService _cartService;

        public CartController(ILogger<CartController> logger, ICartService cartService)
        {
            _logger = logger;
            _cartService = cartService;
        }
        #region  Cart
        [HttpGet]
        public IActionResult MyCart()
        {
            _logger.LogInformation("Fetching Cart Details....");
            string userId = User?.Claims?.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
            var productsInCart = _cartService.GetCartDetails(userId);
            _logger.LogInformation("Fetched Cart Details successfully");

            if (productsInCart == null || productsInCart.Count() == 0)
            {
                _logger.LogInformation("Cart is empty");
                return NotFound("No product is added to cart, Cart Is Empty!!");
            }
            _logger.LogInformation($"{productsInCart.Count()} products are found in the cart");
            return Ok(productsInCart);
        }

        [HttpPost]
        public IActionResult AddToCart(Cart cart)
        {

            string userId = User?.Claims?.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
            cart.UserId = userId;
            _logger.LogInformation("Adding product to cart");
            bool result = _cartService.AddToCart(cart);

            if (!result)
            {
                _logger.LogInformation("Adding Product to cart failed");
                return StatusCode(StatusCodes.Status500InternalServerError, "Can't add this item to cart");
            }
            _logger.LogInformation("Product added to cart Successfully!");
            return CreatedAtAction(nameof(MyCart), "Product added to cart sucessfully!!");
        }
        #endregion

        #region Order

        [HttpGet("[action]")]
        public IActionResult MyOrders()
        {
            string userId = User?.Claims?.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
            _logger.LogInformation("Fetching Order Details..");
            var orderList = _cartService.GetOrderByUserId(userId);
            _logger.LogInformation("Fetched Order Details successfully!");

            if (orderList == null || orderList.Count() == 0)
            {
                _logger.LogInformation("No order placed so far");

                return NotFound("No orders placed yet!!");
            }

            _logger.LogInformation($"{orderList.Count()} Order found");
            return Ok(orderList);
        }

        [HttpPost("[action]")]
        public IActionResult PlaceOrder(Order order)
        {
            string userId = User?.Claims?.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
            order.UserId = userId;

            _logger.LogInformation("Placing order...");
            var result = _cartService.OrderProducts(order);
            if (!result)
            {
                _logger.LogInformation("Failed to place order");
                return StatusCode(StatusCodes.Status500InternalServerError, "Can't Place order, Your cart is empty. Please add items to cart first then Place your order.");
            }
            _logger.LogInformation("Order placed sucessfully!");
            return CreatedAtAction(nameof(MyOrders), "Order Placed succesfully!!");

        }

        [HttpGet("[action]")]
        public IActionResult GetAllOrders()
        {
            _logger.LogInformation("Fetching all placed orders...");
            var orderList = _cartService.GetAllOrders();
            _logger.LogInformation("Order details fetched sucessfully");
            if (orderList == null || orderList.Count() == 0)
            {
                _logger.LogInformation("No order found");
                return NotFound("No Order Placed by any User");
            }
            _logger.LogInformation($"{orderList.Count()} orders found");
            return Ok(orderList);
        }
        #endregion

    }
}