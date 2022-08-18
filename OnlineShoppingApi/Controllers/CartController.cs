using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using OnlineShoppingApi.Models;
using OnlineShoppingApi.Service;

namespace OnlineShoppingApi.Controllers
{
    [Authorize()]
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
    
        [HttpGet]
        public IActionResult Cart()
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
            var result = _cartService.AddToCart(cart);

            if (!result.Item1)
            {
                _logger.LogInformation("Adding Product to cart failed");
                return StatusCode(StatusCodes.Status500InternalServerError, result.Item2);
            }
            _logger.LogInformation("Product added to cart Successfully!");
            return CreatedAtAction(nameof(Cart), "Product added to cart sucessfully!!");
        }

        [HttpDelete]
        public IActionResult Delete(int productId)
        {
            string userId = User?.Claims?.FirstOrDefault(c => c.Type == ClaimTypes.NameIdentifier)?.Value;
            _logger.LogInformation("Removing product from cart");
            bool result = _cartService.RemoveFromCart(productId,userId);

            if (!result)
            {
                _logger.LogInformation("Removing Product from cart failed");
                return StatusCode(StatusCodes.Status500InternalServerError, "Failed:Product not found in the cart");
            }
            _logger.LogInformation("Product removed from cart Successfully!");
            return CreatedAtAction(nameof(Cart), "Product removed from cart sucessfully!!");
        }

    }
}