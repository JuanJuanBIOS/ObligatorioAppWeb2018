using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EntidadesCompartidas
{
    public class Facilidades
    {
        //Atributos
        private string _facilidad;

        //Propiedades
        public string Facilidad
        {
            get { return _facilidad; }

            set
            { _facilidad = value; }
        }


        //Constructor
        public Facilidades(string pFacilidad)
        {
            Facilidad = pFacilidad;
        }

    }
}
