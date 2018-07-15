using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;

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
                if(value.Length == 3)
                {
                    for (int i = 0;  i < value.Length; i++)
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

            set {_ciudad = value; }
        }

        public string Pais
        {
            get { return _pais; }

            set {_pais = value; }
        }

        public List<Facilidades> ListaFacilidades
        {
            get { return _facilidades; }
            set { _facilidades = value; }
        }


        //Constructor
        public Terminales(string pCodigo, string pCiudad, string pPais, List<Facilidades> pFacilidades)
        {
            Codigo=pCodigo;
            Ciudad=pCiudad;
            Pais=pPais;
            ListaFacilidades = pFacilidades;
        }
    }
}
