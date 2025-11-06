using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class Reserva
    {

        public int IdReserva { get; set; }
        public int IdPropiedad { get; set; }
        public int IdHuesped { get; set; }

        public DateTime FechaInicio { get; set; }
        public DateTime FechaFin { get; set; }
        public decimal MontoTotal { get; set; }
        public string EstadoReserva { get; set; }   // “Pendiente”, “Confirmada”, “Cancelada”, etc.
        public DateTime FechaCreacion { get; set; }
        public DateTime? FechaModificacion { get; set; }

        // Relaciones
       public List<Pago> Pagos { get; set; } = new List<Pago>();
        public Calificacion Calificacion { get; set; }

    }
}
