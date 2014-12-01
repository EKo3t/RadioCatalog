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
            FillList();
        }

        public ThemeModel(string theme)
        {
            FillList();

            CurrentItem = theme;
        }

        public void FillList()
        {
            Items = new List<object>();
            Items.Add(new KeyValuePair<string, string>("MSN_Blue", "MSN Blue"));
            Items.Add(new KeyValuePair<string, string>("MSN_CherryBlossom","MSN CherryBlossom"));
        }

        public List<object> Items { get; set; }
        public string CurrentItem { get; set; }
    }
}
