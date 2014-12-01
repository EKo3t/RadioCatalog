using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace RadioCatalog.Helpers
{
    public class HtmlHelper
    {
        public static MvcHtmlString getSchemeText(RadioCatalog.Models.ImageModel model)
        {
            if (model != null)
                return MvcHtmlString.Create(HttpUtility.HtmlDecode(model.CurrentScheme).Replace("\"", "\\\""));
            else
                return MvcHtmlString.Create("");
        }
    }
}