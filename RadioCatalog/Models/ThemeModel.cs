using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RadioCatalog.Models
{
    public class ThemeModel
    {
        public ThemeModel()
        {
            Items = new List<string>();
            Items.Add("MSN_Blue");
            Items.Add("MSN_CherryBlossom");
        }

        public ThemeModel(string theme)
        {
            Items = new List<string>();
            Items.Add("MSN_Blue");
            Items.Add("MSN_CherryBlossom");

            CurrentItem = theme;
        }

        public List<string> Items { get; set; }
        public string CurrentItem { get; set; }
    }
}
