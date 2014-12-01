using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace RadioCatalog.Controllers
{
    public class SchemeController : Controller
    {
        Models.ImageModel imageModel = new Models.ImageModel();

        public ActionResult Save(string jsonString)
        {
            imageModel.CurrentScheme = jsonString;

            return View("~/Views/Account/UserProfile.cshtml", imageModel);
        }

        // GET: Scheme
        public ActionResult Index()
        {
            return View("~/Views/Account/UserProfile.cshtml", imageModel);
        }
    }
}