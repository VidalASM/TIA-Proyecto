Proyecto de Tópicos en Inteligencia Artificial

Título:
- Utilización de una Red Neuronal Convolucional Profunda para Detección de Cáncer de Mama Utilizando Análisis de Imágenes Médicas

Integrantes:
- Diego Andre Ranilla Gallegos
- Vidal Antonio Soncco merma

Preprocesamiento:
- Eliminación de sonido mediante el filtro medio de 3x3
- Eliminación de artefactos de la radiografia y separamos la mama del fondo de la imagen
- Generamos la primera máscara a partir de separar la mama del fondo
- A partir de la primera máscara determinamos el lado en que esta posicionado la mama (perfil izquierdo o derecho)
- Empleando como referencia el perfil de la mama vamos a emplear técnicas de Seeded region growing (SRG) para seleccionar el musculo pectoral y retirarlo de la primera máscara teniendo finalmente la máscara para la segmentación apropiada


Arquitectura:
- La arquitectura que consiste de dos partes:
1- Red Neuronal Concolucional
2- Stacked Autoencoder


Base de Datos:
All Mias 322 imágenes de tamaño de 1024x124 en formato .pgm

Archivo de Entrenamiento:
Archivo de Prueba:


Resultados:
-
