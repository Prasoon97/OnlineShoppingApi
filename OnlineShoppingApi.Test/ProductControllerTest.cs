using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Moq;
using OnlineShoppingApi.Controllers;
using OnlineShoppingApi.Models;
using OnlineShoppingApi.Service;
using Xunit;

namespace OnlineShoppingApi.Test
{

    public class ProductControllerTest
    {

        private readonly Mock<IProductService> _productService;
        private readonly Mock<ILogger<ProductController>> _logger;
        private readonly ProductController _controller;
        public ProductControllerTest()
        {
            _productService = new Mock<IProductService>();
            _logger = new Mock<ILogger<ProductController>>();
            _controller = new ProductController(_logger.Object, _productService.Object);
        }
        [Fact]
        public void GetAllProducts_IfProductExist_ReturnsOk()
        {
            //arrange
            string orderBy = null;
            IQueryable<Product> expectdResult = new List<Product>()
               {
                new Product() { Id = 1, Price = 1000, Name = "Test Product1", Category = "Test Category1", Description = "Test description 1", DateAdded = DateTime.Now },
                new Product() { Id = 2, Price = 2000, Name = "Test Product2", Category = "Test Category1", Description = "Test description 2", DateAdded = DateTime.Now },
                new Product() { Id = 3, Price = 3000, Name = "Test Product3", Category = "Test Category2", Description = "Test description 3", DateAdded = DateTime.Now },
                new Product() { Id = 4, Price = 4000, Name = "Test Product4", Category = "Test Category3", Description = "Test description 4", DateAdded = DateTime.Now },
                new Product() { Id = 5, Price = 5000, Name = "Test Product5", Category = "Test Category2", Description = "Test description 5", DateAdded = DateTime.Now }

                }.AsQueryable();

            _productService.Setup(x => x.GetAllProducts(orderBy)).Returns(expectdResult);

            //Act
            var actionResult = _controller.Get(orderBy);
            var result = actionResult as OkObjectResult;

            //Assert
            Assert.IsType<OkObjectResult>(result);
            Assert.NotNull(result);
            Assert.Equal(expectdResult, result.Value);

        }

        [Fact]
        public void GetById_IfProductExist_ReturnsOk()
        {
            //Arrange
            int id = 1;
            Product expectdResult = new Product()
            {
                Id = id,
                Price = 1000,
                Name = "Test Product1",
                Category = "Test Category1",
                Description = "Test description 1",
                DateAdded = DateTime.Now
            };

            _productService.Setup(x => x.GetProductById(id)).Returns(expectdResult);

            //Act
            var actionResult = _controller.Get(id);
            var result = actionResult as OkObjectResult;
            //Assert 
            Assert.IsType<OkObjectResult>(result);
            Assert.Equal(expectdResult, result.Value);

        }

        [Fact]
        public void GetById_IfProductNotExist_ReturnsNotFound()
        {
            //Arrange
            int id = 1;
            Product nullProduct = null;
            string expectedMessage = "Product not found";
            _productService.Setup(x => x.GetProductById(id)).Returns(nullProduct);

            //Act
            var actionResult = _controller.Get(id);
            var result = actionResult as NotFoundObjectResult;

            //Assert 
            Assert.IsType<NotFoundObjectResult>(result);
            Assert.Equal(expectedMessage, result.Value);

        }

        [Fact]
        public void SearchByCategory_IfProductFound_ReturnstOk()
        {
            //Arrange
            string category = "Test Category1";
            IQueryable<Product> expectdResult = new List<Product>()
            {
              new Product() { Id = 1, Price = 1000, Name = "Test Product1", Category = "Test Category1", Description = "Test description 1", DateAdded = DateTime.Now },
              new Product() { Id = 2, Price = 2000, Name = "Test Product2", Category = "Test Category1", Description = "Test description 2", DateAdded = DateTime.Now },
            }.AsQueryable();

            _productService.Setup(x => x.GetProductsByCategory(category)).Returns(expectdResult);

            //Act
            var actionResult = _controller.Search(category);
            var result = actionResult as OkObjectResult;
            Assert.IsType<OkObjectResult>(result);
            Assert.Equal(expectdResult, result.Value);

        }


        [Fact]
        public void SearchByCategory_IfProductNotExistForCategory_ReturnstNotFound()
        {
            //Arrange
            string expectedMessage = "No Product Found for this category";
            string category = "Test Category";
            IQueryable<Product> blankList = new List<Product>().AsQueryable();

            _productService.Setup(x => x.GetProductsByCategory(category)).Returns(blankList);

            //Act
            var actionResult = _controller.Search(category);
            var result = actionResult as NotFoundObjectResult;
            Assert.IsType<NotFoundObjectResult>(result);
            Assert.Equal(expectedMessage, result.Value);

        }

        [Fact]
        public void AddProduct_IfProductIsAdded_Returns201Created()
        {
            //Arrange
            Product product = new Product()
            {
                Price = 1000,
                Name = "Test Product1",
                Category = "Test Category1",
                Description = "Test description 1",
                DateAdded = DateTime.Now
            };
            _productService.Setup(x => x.AddProduct(product)).Returns(true);

            //Act
            var actionResult = _controller.AddProduct(product);
            var result = actionResult as ObjectResult;

            //Assert
            Assert.IsType<ObjectResult>(result);
            Assert.Equal(StatusCodes.Status201Created, result.StatusCode);

        }

        [Fact]
        public void AddProduct_IfProductAddIsUnsuccessfull_Returns500InternalServerError()
        {
            //Arrange
            Product product = new Product()
            {
                Price = 1000,
                Name = "Test Product1",
                Category = "Test Category1",
                Description = "Test description 1",
                DateAdded = DateTime.Now
            };
            _productService.Setup(x => x.AddProduct(product)).Returns(false);

            //Act
            var actionResult = _controller.AddProduct(product);
            var result = actionResult as ObjectResult;

            //Assert
            Assert.IsType<ObjectResult>(result);
            Assert.Equal(StatusCodes.Status500InternalServerError, result.StatusCode);
            Assert.Equal("Product was not added", result.Value);

        }


        [Fact]
        public void AddProductInBulk_IfProductsAreAdded_Returns201Created()
        {
            //Arrange
            IEnumerable<Product> productsToBeAdded = new List<Product>()
            {
                new Product() { Id = 1, Price = 1000, Name = "Test Product1", Category = "Test Category1", Description = "Test description 1", DateAdded = DateTime.Now },
                new Product() { Id = 2, Price = 2000, Name = "Test Product2", Category = "Test Category1", Description = "Test description 2", DateAdded = DateTime.Now },
                new Product() { Id = 3, Price = 3000, Name = "Test Product3", Category = "Test Category2", Description = "Test description 3", DateAdded = DateTime.Now },
                new Product() { Id = 4, Price = 4000, Name = "Test Product4", Category = "Test Category3", Description = "Test description 4", DateAdded = DateTime.Now },
                new Product() { Id = 5, Price = 5000, Name = "Test Product5", Category = "Test Category2", Description = "Test description 5", DateAdded = DateTime.Now }

            };
            _productService.Setup(x => x.AddProductsInBulk(productsToBeAdded)).Returns(true);

            //Act
            var actionResult = _controller.AddProductInBulk(productsToBeAdded);
            var result = actionResult as ObjectResult;

            //Assert
            Assert.IsType<ObjectResult>(result);
            Assert.Equal(StatusCodes.Status201Created, result.StatusCode);

        }

        [Fact]
        public void AddProductInBulk_IfProductsAreNotAdded_Returns500InternalServerError()
        {
            //Arrange
            IEnumerable<Product> productsToBeAdded = new List<Product>()
            {
                new Product() { Id = 1, Price = 1000, Name = "Test Product1", Category = "Test Category1", Description = "Test description 1", DateAdded = DateTime.Now },
                new Product() { Id = 2, Price = 2000, Name = "Test Product2", Category = "Test Category1", Description = "Test description 2", DateAdded = DateTime.Now },
                new Product() { Id = 3, Price = 3000, Name = "Test Product3", Category = "Test Category2", Description = "Test description 3", DateAdded = DateTime.Now },
                new Product() { Id = 4, Price = 4000, Name = "Test Product4", Category = "Test Category3", Description = "Test description 4", DateAdded = DateTime.Now },
                new Product() { Id = 5, Price = 5000, Name = "Test Product5", Category = "Test Category2", Description = "Test description 5", DateAdded = DateTime.Now }
            };
            _productService.Setup(x => x.AddProductsInBulk(productsToBeAdded)).Returns(false);

            //Act
            var actionResult = _controller.AddProductInBulk(productsToBeAdded);
            var result = actionResult as ObjectResult;

            //Assert
            Assert.IsType<ObjectResult>(result);
            Assert.Equal(StatusCodes.Status500InternalServerError, result.StatusCode);
            Assert.Equal("Products were not added", result.Value);

        }

        [Fact]
        public void Delete_IfValidId_ReturnsOk()
        {
            //Arrange
            _productService.Setup(x => x.DeleteProduct(It.IsAny<int>())).Returns(true);

            //Act
            var actionResult = _controller.Delete(It.IsAny<int>());
            var result = actionResult as ObjectResult;

            //Assert
            Assert.IsType<ObjectResult>(result);
            Assert.Equal(StatusCodes.Status200OK, result.StatusCode);
        }
    }

}