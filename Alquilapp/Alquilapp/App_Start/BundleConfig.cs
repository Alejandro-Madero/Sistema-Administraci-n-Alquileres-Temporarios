using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.UI;

namespace AlquilApp
{
    public class BundleConfig
    {
        // For more information on Bundling, visit https://go.microsoft.com/fwlink/?LinkID=303951
        public static void RegisterBundles(BundleCollection bundles)
        {
            RegisterJQueryScriptManager();

            bundles.Add(new ScriptBundle("~/bundles/WebFormsJs").Include(
                            "~/Scripts/WebForms/WebForms.js",
                            "~/Scripts/WebForms/WebUIValidation.js",
                            "~/Scripts/WebForms/MenuStandards.js",
                            "~/Scripts/WebForms/Focus.js",
                            "~/Scripts/WebForms/GridView.js",
                            "~/Scripts/WebForms/DetailsView.js",
                            "~/Scripts/WebForms/TreeView.js",
                            "~/Scripts/WebForms/WebParts.js"));

            // Order is very important for these files to work, they have explicit dependencies
            bundles.Add(new ScriptBundle("~/bundles/MsAjaxJs").Include(
                    "~/Scripts/WebForms/MsAjax/MicrosoftAjax.js",
                    "~/Scripts/WebForms/MsAjax/MicrosoftAjaxApplicationServices.js",
                    "~/Scripts/WebForms/MsAjax/MicrosoftAjaxTimer.js",
                    "~/Scripts/WebForms/MsAjax/MicrosoftAjaxWebForms.js"));

            // Use the Development version of Modernizr to develop with and learn from. Then, when you’re
            // ready for production, use the build tool at https://modernizr.com to pick only the tests you need
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                            "~/Scripts/modernizr-*"));

            //Mis estilos: 
            bundles.Add(new StyleBundle("~/Content/default")
             .Include("~/Styles/default.css"));

            bundles.Add(new StyleBundle("~/Content/login")
            .Include("~/Styles/login.css"));

            bundles.Add(new StyleBundle("~/Content/registro")
          .Include("~/Styles/registro.css"));

            bundles.Add(new StyleBundle("~/Content/detallepropiedad")
          .Include("~/Styles/detallepropiedad.css"));

            bundles.Add(new StyleBundle("~/Content/publicarpropiedad")
         .Include("~/Styles/publicarpropiedad.css"));

            bundles.Add(new StyleBundle("~/Content/misreservas")
         .Include("~/Styles/misreservas.css"));

            bundles.Add(new StyleBundle("~/Content/mispropiedades")
         .Include("~/Styles/mispropiedades.css"));

            bundles.Add(new StyleBundle("~/Content/listado")
        .Include("~/Styles/listado.css"));


            bundles.Add(new StyleBundle("~/Content/calificarreserva")
        .Include("~/Styles/calificarreserva.css"));

            bundles.Add(new StyleBundle("~/Content/editarpropiedad")
        .Include("~/Styles/editarpropiedad.css"));

            BundleTable.EnableOptimizations = false;

        }

        public static void RegisterJQueryScriptManager()
        {
            ScriptManager.ScriptResourceMapping.AddDefinition("jquery",
                new ScriptResourceDefinition
                {
                    Path = "~/scripts/jquery-3.7.0.min.js",
                    DebugPath = "~/scripts/jquery-3.7.0.js",
                    CdnPath = "http://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.7.0.min.js",
                    CdnDebugPath = "http://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.7.0.js"
                });
        }
    }
}