using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;
using Moq;
using WebApp.Pages;
using Xunit;

namespace WebApp.Tests
{
    public class IndexModelTests
    {
        [Fact]
        public void OnPost_WithValidMessage_ReturnsPageResult()
        {
            // Arrange
            var loggerMock = new Mock<ILogger<IndexModel>>();
            var pageModel = new IndexModel(loggerMock.Object)
            {
                Message = "Test Message"
            };

            // Act
            var result = pageModel.OnPost();

            // Assert
            Assert.IsType<PageResult>(result);
            Assert.Equal("Test Message", pageModel.SubmittedMessage);
        }

        [Fact]
        public void OnPost_WithEmptyMessage_ReturnsPageResultWithModelError()
        {
            // Arrange
            var loggerMock = new Mock<ILogger<IndexModel>>();
            var pageModel = new IndexModel(loggerMock.Object)
            {
                Message = string.Empty
            };
            pageModel.ModelState.Clear();

            // Act
            var result = pageModel.OnPost();

            // Assert
            Assert.IsType<PageResult>(result);
            Assert.False(pageModel.ModelState.IsValid);
        }
    }
}