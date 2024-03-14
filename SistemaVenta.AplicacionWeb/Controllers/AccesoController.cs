using Microsoft.AspNetCore.Mvc;
using SistemaVenta.AplicacionWeb.Models.ViewModels;
using SistemaVenta.BLL.Interfaces;
using SistemaVenta.Entity;
using System.Security.Claims;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using System.Xml.Linq;
using System.Numerics;


namespace SistemaVenta.AplicacionWeb.Controllers
{
    public class AccesoController : Controller
    {
        private readonly IUsuarioService _usuarioServicio;

        public AccesoController(IUsuarioService usuarioServicio)
        {
            _usuarioServicio = usuarioServicio;
        }

        public IActionResult Login()
        {
            ClaimsPrincipal claimUser = HttpContext.User;

            if (claimUser.Identity.IsAuthenticated) {
                return RedirectToAction("Index", "Home");
            }
            return View();
        }

        public IActionResult RestablecerClave()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Login(VMUsuarioLogin modelo)
        {
            if (modelo.Correo==null)
            {
                ViewData["Mensaje"] = "No se ha introducido correo, intente nuevamente.";
                return View();
            }
            if (modelo.Clave == null)
            {
                ViewData["Mensaje"] = "No se a introducido contraseña, intente nuevamente.";
                return View();
            }

            Usuario usuario_encontrado = await _usuarioServicio.ObtenerPorCredenciales(modelo.Correo, modelo.Clave);

            if (usuario_encontrado == null)
            {
                ViewData["Mensaje"] = "El correo o contraseña, no son correctos, favor de intentar nuevamente, gracias.";
                return View();
            }

            if (usuario_encontrado.EsActivo == false)
            {
                ViewData["Mensaje"] = "El usuario está desactivado, favor de acudir con su administrador del sistema, gracias.";
                return View();
            }

            ViewData["Mensaje"] = null;

            List<Claim> claims = new List<Claim>() { 
                new Claim(ClaimTypes.Name, usuario_encontrado.Nombre),
                new Claim(ClaimTypes.NameIdentifier, usuario_encontrado.IdUsuario.ToString()),
                new Claim(ClaimTypes.Role, usuario_encontrado.IdRol.ToString()),
                new Claim("UrlFoto", usuario_encontrado.UrlFoto),
            };

            ClaimsIdentity claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);

            AuthenticationProperties properties = new AuthenticationProperties() { 
                AllowRefresh = true,
                IsPersistent = modelo.MantenerSesion,
            };

            await HttpContext.SignInAsync(
                CookieAuthenticationDefaults.AuthenticationScheme,
                new ClaimsPrincipal(claimsIdentity),
                properties
                );

            return RedirectToAction("Index","Home");

        }

        [HttpPost]
        public async Task<IActionResult> RestablecerClave(VMUsuarioLogin modelo)
        {
            try
            {
                string urlPlantillaCorreo = $"{this.Request.Scheme}://{this.Request.Host}/Plantilla/RestablecerClave?clave=[clave]";

                bool resultado = await _usuarioServicio.RestablecerClave(modelo.Correo, urlPlantillaCorreo);

                if (resultado)
                {
                    ViewData["Mensaje"] = "Proceso Existoso. Su contraseña fue restablecida, revise su correo.";
                    ViewData["MensajeError"] = null;
                }
                else
                {
                    ViewData["Mensaje"] = null;
                    ViewData["MensajeError"] = "UPS, algo salió mal. Favor de intentarlo más tarde.";
                }
            }
            catch (Exception ex)
            {
                ViewData["Mensaje"] = null;
                ViewData["MensajeError"] = ex.Message;
            }

            return View();
        }


    }
}
