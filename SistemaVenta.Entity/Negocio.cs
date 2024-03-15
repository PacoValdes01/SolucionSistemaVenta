using System;
using System.Collections.Generic;

namespace SistemaVenta.Entity
{
    public partial class Negocio
    {
        public int IdNegocio { get; set; }
        public string? UrlLogo { get; set; }
        public string? NombreLogo { get; set; }
        public string? RFC { get; set; }
        public string? RégimenFiscal { get; set; }
        public string? CódigoPostal { get; set;}
        public string? Correo { get; set; }
        public string? Direccion { get; set; }
        public string? Telefono { get; set; }
        public string? SimboloMoneda { get; set; }
        public string? RazonSocial { get; set; }

    }
}
