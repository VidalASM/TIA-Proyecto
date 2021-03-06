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

En la carpeta "Preprocesamiento" está el código hecho en matlab del preprocesamiento de las mamografías, en el archivo "proyecto.m" llama al conjunto de archivos que contienen funciones para esta etapa, la salida de estecódigo es una carpeta con la máscara y la imagen original para su posterior segmentación.


Arquitectura:
La arquitectura que consiste de una red Neuronal convolucional, esta red neuronal contiene principalmente estas capas:
- Convolutional layer,
- Maximum pooling layer,
- Convolutional layer
- softmax classifier

Base de Datos:
- All Mias 322 imágenes de tamaño de 1024x124 en formato .pgm

Archivo de Entrenamiento:
- cnn_train.py

Archivo de Prueba:
- Carpeta Test del repositorio


Resultados:
- A comparación de lo presentado en el paper, se tuvo dificultad al entrenarlo por lo que tuvimos que hacer uno cambios para poder obtener una clusterización buena, sobre la red se entrenó con 15 epochs, se realizó una matriz de confusión la cual es la imagen "Matriz de Confusión.png", lo que podemos decir sobre estos resultados es que a pesar que se haya variado la cantidad de epochs, la CNN ha podido clasificar de forma casi correcta las tres clases (Beningno, Maligno y Normal).
