# -*- coding: utf-8 -*-
"""
Created on Thu Mar  7 22:11:12 2024

@author: Diego Javier Silva
"""

# Importa packages
from dash import Dash, html, dash_table, dcc, callback, Output, Input
import datetime
import pandas as pd
import plotly.express as px
import pandas as pd

pd.options.display.float_format = '{:.2f}'.format

# lee los archivos de datos y los almacena en dataframe
df_rev = pd.read_csv("C:\\Users\\aliso\\Downloads\\revenue_2022.csv")
df_cost = pd.read_csv("C:\\Users\\aliso\\Downloads\\costs_2022.csv")



# hace unpivot de las columnas de meses en registros
df_rev_unpv =  pd.melt(df_rev, id_vars=['N','Client Name','Line Of Business'], value_vars=['Jan', 'Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Total'])
df_cost_unpv =  pd.melt(df_cost , id_vars=['N','Expense Item','Line Of Business'], value_vars=['Jan', 'Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec','Total'])

# realiza estandarizacion de datos para poder usarlos como valores numericos y estandariza las lineas de negocio para permitir la comparacion
df_rev_unpv['value'] = df_rev_unpv['value'].str.replace('$', '').str.replace('.', 'x').str.replace(',', '').str.replace('x', '.').astype(float)
df_rev_unpv['Line Of Business'] = df_rev_unpv['Line Of Business'].str.replace(' Revenue', '')
df_rev_unpv.rename({'value': 'value','variable': 'months'}, axis=1, inplace=True)
df_cost_unpv.rename({'value': 'value','variable': 'months'}, axis=1, inplace=True)


# realiza agregacion a nivel de linea de negocio  y mes para permitir la comparacion
df_rev_group = df_rev_unpv.groupby(['Line Of Business','months'])['value'].sum().reset_index()
df_cost_group = df_cost_unpv.groupby(['Line Of Business','months'])['value'].sum().reset_index()

# agrega el mes numerico
df_rev_group2 = df_rev_group[df_rev_group["months"] != 'Total']  
df_rev_group2['monthnumb'] = pd.to_datetime(df_rev_group2['months'], format='%b').dt.month
df_rev_group2['metrica'] = 'revenue' 

df_cost_group2 = df_cost_group[df_cost_group["months"] != 'Total']  
df_cost_group2['monthnumb'] = pd.to_datetime(df_cost_group2['months'], format='%b').dt.month
df_cost_group2['metrica'] = 'cost'

# hace join de las tablas para comparar por mes y linea de negocio el costo y el revenue
#result =  pd.merge(df_rev_group2, df_cost_group2, how = "outer", on=["Line Of Business", "months","monthnumb"])
result =  pd.concat([df_rev_group2, df_cost_group2],ignore_index=True)
result=result.sort_values(by="monthnumb")

app = Dash(__name__)

app.layout = html.Div([
    html.H1(children='Ingresos Vs Costos', style={'textAlign':'center'}),
    dcc.Dropdown(
         id="line-charts-x-checklist",
         options=["Company Signature", "Company Beyond", "Event Production","Product Development Expenses","Sales Discounts & Refunds"],
         value=["Company Signature"],
         multi = True

      ),


    dcc.Graph(id="line-charts-x-graph"),

 

    
])

@app.callback(
    Output("line-charts-x-graph", "figure"), 
    Input("line-charts-x-checklist", "value"))
def update_line_chart(opcion):
    df = result # replace with your own data source
    mask = result['Line Of Business'].isin(opcion)
    fig = px.line(df[mask], 
        x="months", y="value", color='metrica', markers=True)
    return fig

if __name__ == '__main__':
    app.run(debug=True)