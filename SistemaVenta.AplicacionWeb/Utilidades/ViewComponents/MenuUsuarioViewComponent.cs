using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace SistemaVenta.AplicacionWeb.Utilidades.ViewComponents
{
    public class MenuUsuarioViewComponent : ViewComponent   
    {
        public async Task<IViewComponentResult> InvokeAsync()
        {
            ClaimsPrincipal claimUser = HttpContext.User;

            string nombreUsuario = "";
            string urlFotoUsurio = "";

            if (claimUser.Identity.IsAuthenticated)
            {
                nombreUsuario = claimUser.Claims
                    .Where(c => c.Type == ClaimTypes.Name)
                    .Select(c => c.Value).SingleOrDefault();

                urlFotoUsurio = ((ClaimsIdentity)claimUser.Identity).FindFirst("urlFoto").Value;
            }

            ViewData["nombreUsuario"] = nombreUsuario;
            ViewData["urlFotoUsuario"] = urlFotoUsurio;

            return View();
        }
    }
}
