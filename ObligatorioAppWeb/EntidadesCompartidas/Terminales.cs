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
        private List<string> _facilidades = new List<string>();

        //Propiedades
        public string Codigo
        {
            get { return _codigo; }

            set
            {
                if(value.Length == 3)   //FALTA AGREGAR EL CÓDIGO DEFENSIVO PARA QUE VERIFIQUE QUE SEAN TRES LETRAS
                                        //TIENE PINTA DE QUE PUEDE SER USANDO EXPRESIONES REGULARES
                {
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

        public List<string> Facilidades
        {
            get {return _facilidades;}

            set
            {
                foreach (string facilidad in Facilidades)
                {
                    _facilidades.Add(facilidad);
                }

                _facilidades = value;
            }
        }


        //Constructor
        public Terminales(string pCodigo, string pCiudad, string pPais, List<string> pFacilidades)
        {
            Codigo=pCodigo;
            Ciudad=pCiudad;
            Pais=pPais;
            Facilidades=pFacilidades;
        }
    }
}
