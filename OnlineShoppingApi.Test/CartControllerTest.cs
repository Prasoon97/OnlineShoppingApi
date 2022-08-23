using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Moq;
using OnlineShoppingApi.Controllers;
using OnlineShoppingApi.Models;
using OnlineShoppingApi.Service;
using Xunit;
using static OnlineShoppingApi.Common.Constants;

namespace OnlineShoppingApi.Test
{

    public class CartControllerTest
    {
        private readonly CartController _controller;
        Mock<ILogger<CartController>> _logger;
        Mock<ICartService> _cartService;

        public CartControllerTest()
        {
            _logger = new Mock<ILogger<CartController>>();
            _cartService = new Mock<ICartService>();
            _controller = new CartController(_logger.Object, _cartService.Object);
        }

        [Fact]
        public void MyCart_IfCartHasProduct_ReturnsOk()
        {
            //Arrange
            string userId = "testuserid";
            IQueryable<Cart> expectedCartDetails = new List<Cart>(){
                new Cart{ CartId=1, ProductId=1, Quantity=1,OrderId=null, UserId=userId},
                new Cart{ CartId=2, ProductId=10, Quantity=5,OrderId=null, UserId=userId}

            }.AsQueryable();
            _cartService.Setup(x => x.GetCartDetails(It.IsAny<string>())).Returns(expectedCartDetails);

            //Act
            var actionResult = _controller.Cart();
            var result = actionResult as OkObjectResult;

            //Assert
            Assert.IsType<OkObjectResult>(result);
            Assert.Equal(expectedCartDetails, result.Value);
        }

        [Fact]
        public void MyCart_IfCartIsEmpty_ReturnsNotFound()
        {
            //Arrange
            string expectedMessage = "No product is added to cart, Cart Is Empty!!";
            IQueryable<Cart> emptyCartResult = new List<Cart>().AsQueryable();
            _cartService.Setup(x => x.GetCartDetails(It.IsAny<string>())).Returns(emptyCartResult);

            //Act
            var actionResult = _controller.Cart();
            var result = actionResult as NotFoundObjectResult;

            //Assert
            Assert.IsType<NotFoundObjectResult>(result);
            Assert.Equal(expectedMessage, result.Value);
        }

        [Fact]
        public void AddToCart_IfProductAddedToCart_ReturnsOk()
        {
            //Arrange
            Cart cartDetailToBeAdded = new Cart
            {
                CartId = 1,
                ProductId = 1,
                Quantity = 1,
                OrderId = null,
                UserId = "testuserid"
            };
            _cartService.Setup(x => x.AddToCart(cartDetailToBeAdded)).Returns((true,"Success"));

            //Act
            var actionResult = _controller.AddToCart(cartDetailToBeAdded);
            var result = actionResult as OkObjectResult;

            //Assert
            Assert.IsType<OkObjectResult>(result);
            Assert.Equal(StatusCodes.Status200OK, result.StatusCode);
        }

        [Fact]
        public void AddToCart_IfProductIsNotAddedToCart_Returns500InternalServerError()
        {
            //Arrange
            Cart cartDetailToBeAdded = new Cart
            {
                CartId = 1,
                ProductId = 1,
                Quantity = 1,
                OrderId = null,
                UserId = "testuserid"
            };
            _cartService.Setup(x => x.AddToCart(cartDetailToBeAdded)).Returns((false,"Error"));

            //Act
            var actionResult = _controller.AddToCart(cartDetailToBeAdded);
            var result = actionResult as ObjectResult;

            //Assert
            Assert.IsType<ObjectResult>(result);
            Assert.Equal(StatusCodes.Status500InternalServerError, result.StatusCode);
        }

      
    }
}