using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public class Calificacion
    {
        public int IdCalificacion {  get; set; }
        public int IdReserva {  get; set; }
        public int Puntuacion { get; set; }
        public string Reseña { get; set; }

        public DateTime FechaCalificacion { get; set; }
    }
}
