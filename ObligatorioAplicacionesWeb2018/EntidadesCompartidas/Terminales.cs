using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EntidadesCompartidas
{
    public class Terminales
    {
        //Atributos
        private string _codigo;
        private string _ciudad;
        private string _pais;
        private List<Facilidades> _facilidades = new List<Facilidades>();

        //Propiedades
        public string Codigo
        {
            get { return _codigo; }

            set
            {
                if (value.Length == 3)
                {
                    for (int i = 0; i < value.Length; i++)
                    {
                        if (!Char.IsLetter(Convert.ToChar(value.Substring(i, 1))))
                        {
                            throw new Exception("ERROR: El código de la terminal debe constar de tres letras");
                        }
                    }
                    _codigo = value;
                }
                else
                {
                    throw new Exception("El código ingresado debe constar de 3 letras");
                }
            }
        }

        public string Ciudad
        {
            get { return _ciudad; }

            set
            {
                if (value.Length <= 50)
                {
                    _ciudad = value;
                }
                else
                {
                    throw new Exception("El nombre de la ciudad no puede contener más de 50 caracteres");
                }
            }
        }

        public string Pais
        {
            get { return _pais; }

            set
            {
                if (value == "Argentina" || value == "Brasil" || value == "Paraguay" || value == "Uruguay")
                {
                    _pais = value;
                }
                else
                {
                    throw new Exception("El país debe pertenecer al MERCOSUR");
                }
            }
        }

        public List<Facilidades> ListaFacilidades
        {
            get { return _facilidades; }
            set
            {
                if (value != null)
                {
                    _facilidades = value;
                }
                else
                {
                    throw new Exception("La lista de facilidades ingresada no es válida");
                }
            }
        }


        //Constructor
        public Terminales(string pCodigo, string pCiudad, string pPais, List<Facilidades> pFacilidades)
        {
            Codigo = pCodigo;
            Ciudad = pCiudad;
            Pais = pPais;
            ListaFacilidades = pFacilidades;
        }
    }
}
