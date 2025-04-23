using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace WebApp.Pages
{
    public class IndexModel : PageModel
    {
        private readonly ILogger<IndexModel> _logger;

        [BindProperty]
        public string Message { get; set; }
        
        public string SubmittedMessage { get; set; }

        public IndexModel(ILogger<IndexModel> logger)
        {
            _logger = logger;
        }

        public void OnGet()
        {
            // Initialize page
        }
        
        public IActionResult OnPost()
        {
            if (string.IsNullOrWhiteSpace(Message))
            {
                ModelState.AddModelError("Message", "Message cannot be empty");
                return Page();
            }
            
            _logger.LogInformation($"Message submitted: {Message}");
            SubmittedMessage = Message;
            
            return Page();
        }
    }
}