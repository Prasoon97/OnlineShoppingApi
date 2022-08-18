using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using OnlineShoppingApi.Models;
using OnlineShoppingApi.Service;

namespace OnlineShoppingApi.Controllers
{

    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private readonly ILogger<ProductController> _logger;
        private readonly IProductService _productService;
        public ProductController(ILogger<ProductController> logger, IProductService productService)
        {
            _logger = logger;
            _productService = productService;
        }

        [HttpGet(Name = "GetAllProducts")]
        public IActionResult Get(string? orderBy)
        {

            _logger.LogInformation("Fetching All product...");
            var productList = _productService.GetAllProducts(orderBy);
            _logger.LogInformation("All product fetched successfully!");
            return Ok(productList);
        }

        [HttpGet("{id:int}")]
        public IActionResult Get(int id)
        {
            _logger.LogInformation($"Fetching Products for Id: {id}");
            var product = _productService.GetProductById(id);
            _logger.LogInformation($"Product fetched successfully!");
            if (product == null)
            {
                _logger.LogInformation($"No product exist for Id: {id}");
                return NotFound("Product not found");
            }
            _logger.LogInformation($"Product found");
            return Ok(product);

        }

        [HttpGet("{category:alpha}")]
        public IActionResult Search(string category)
        {
            _logger.LogInformation($"Fetching Products for category {category}");
            var productList = _productService.GetProductsByCategory(category);
            _logger.LogInformation($"Products fetched successfully!");
            if (productList == null || productList.Count() == 0)
            {
                _logger.LogInformation($"No Product Found for category: {category}");
                return NotFound("No Product Found for this category");
            }
            _logger.LogInformation($"{productList.Count()} products found for category: {category}");
            return Ok(productList);
        }



        [HttpPost]
        public IActionResult AddProduct(Product product)
        {
            _logger.LogInformation("Adding Product..");
            var isAdded = _productService.AddProduct(product);
            if (!isAdded)
            {
                _logger.LogInformation("Product cannot be added");
                return StatusCode(StatusCodes.Status500InternalServerError, "Product was not added");
            }
            _logger.LogInformation("Product added sucessfully!");
            return StatusCode(StatusCodes.Status201Created, "Product Added succesfully!!");

        }

        [HttpPost("[action]")]
        public IActionResult AddProductInBulk(IEnumerable<Product> productList)
        {
            _logger.LogInformation("Adding Products in bulk..");
            var isAdded = _productService.AddProductsInBulk(productList);
            if (!isAdded)
            {
                _logger.LogInformation("Products cannot be added.");
                return StatusCode(StatusCodes.Status500InternalServerError, "Products were not added");
            }
            _logger.LogInformation("Products added sucessfully!");
            return StatusCode(StatusCodes.Status201Created, "Products are Added succesfully!!");

        }

        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            _logger.LogInformation("Deleting product");
            var isDeleted = _productService.DeleteProduct(id);
            if (!isDeleted)
            {
                _logger.LogInformation("Products cannot be deleted.");
                return StatusCode(StatusCodes.Status500InternalServerError, "Failed: Product not deleted");
            }
            _logger.LogInformation("Product deleted sucessfully!");
            return StatusCode(StatusCodes.Status200OK, "Product deleted succesfully!!");

        }

    }
}
