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
            {
                if (value.Length <= 50)
                {
                    _facilidad = value;
                }
                else
                {
                    throw new Exception("El nombre de la facilidad no puede contener más de 50 caracteres");
                }
            }
        }


        //Constructor
        public Facilidades(string pFacilidad)
        {
            Facilidad = pFacilidad;
        }
    }
}
