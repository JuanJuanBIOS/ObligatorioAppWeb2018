using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EntidadesCompartidas
{
    public class Companias
    {
        //Atributos
        private string _nombre;
        private string _direccion;
        private string _telefono;

        //Propiedades
        public string Nombre
        {
            get { return _nombre; }

            set
            {
                if (value.Length <= 50)
                {
                    _nombre = value;
                }
                else
                {
                    throw new Exception("El nombre de la compañía no puede contener más de 50 caracteres");
                }
            }
        }

        public string Direccion
        {
            get { return _direccion; }

            set
            {
                if (value.Length <= 100)
                {
                    _direccion = value;
                }
                else
                {
                    throw new Exception("La dirección no puede contener más de 100 caracteres");
                }
            }
        }

        public string Telefono
        {
            get { return _telefono; }

            set
            {
                try
                {
                    if (Convert.ToInt64(value) > 0 && value.Length > 7 && value.Length <= 20)
                    {
                        _telefono = value;
                    }
                    else
                    {
                        throw new Exception("El número de teléfono ingresado no es válido");
                    }
                }

                catch
                {
                    throw new Exception("El número de teléfono ingresado no es válido");
                }
            }
        }

        //Constructor
        public Companias(string pNombre, string pDireccion, string pTelefono)
        {
            Nombre = pNombre;
            Direccion = pDireccion;
            Telefono = pTelefono;
        }
    }
}
