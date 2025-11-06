using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class Pago
    {
        public int IdPago { get; set; }
        public int IdReserva { get; set; }
        public int IdMedioPago { get; set; }
        public DateTime FechaPago { get; set; }
        public decimal Importe { get; set; }
        public string EstadoPago { get; set; }
        public MedioPago MedioPago { get; set; }

    }
}
