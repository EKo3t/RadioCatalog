using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace RadioCatalog.Controllers
{
    public class ThemeController : Controller
    {
        Models.ThemeModel model = new Models.ThemeModel();
        const string cookieName = "_theme";

        public ActionResult SetTheme(string theme)
        {
            model.CurrentItem = theme;

            HttpCookie cookie = Request.Cookies[cookieName];
            if (cookie != null)
                cookie.Value = theme;
            else
            {
                cookie = new HttpCookie(cookieName);
                cookie.Value = theme;
                cookie.Expires = DateTime.Now.AddYears(1);
            }
            Response.Cookies.Add(cookie);
            
            return RedirectToAction("Index", "Home");
        }

        // GET: Theme
        public ActionResult ChangeTheme()
        {
            if (model.CurrentItem == "")
            {
                HttpCookie cookie = Request.Cookies[cookieName];
                if (cookie != null)
                    model.CurrentItem = cookie.Value;
            }

            return View(model);
        }
    }
}