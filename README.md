# Github Actions



### Principales características

* Usa YAML.

* Soporta Windows, MaxOS y Linux

* Soporta cualquier lenguaje de programación que corra en los OS anteriores

* Podes crear tus propios Runners privados

* Puede ser disparado por cambios y PR ademas en base a ciertos Github events como:

  Creación de Issues, Comentarios, agregado de un nuevo usuario al repo, etc

  

------

### Workflows

Un `workflow` es un proceso configurable que esta compuesto de uno o mas `jobs` (Seria como en otro caso tienen pipelines y stages). Los workflow usan sintaxis yaml, y se tienen que crear en el directorio `.github/workflows` del repositorio.

Los workflows tienen que tener al menos un `job` y los `jobs` tendrán una serie de `steps`, estos últimos son los que ejecutaran los comandos o usaran una `action`. Podremos crear nuestras actions, o usar de Terceros.

**Limitaciones:**

* Tiempo de ejecución de un job máximo de 6 horas (no aplica a self-hosted runners)
* Tiempo de ejecución de un Workflow máximo de 72 horas 
* Máximo de 1000 API requests en una hora para todos los actions en un repositorio
* Limite de jobs concurrentes, 20 para la versión free
* Una Job Matrix puede generar un máximo de 256 jobs por Workflow



____

### Workflow de ejemplo

```
# This is a basic workflow to help you get started with Actions

name: CI

# Controls when the action will run. Triggers the workflow on push or pull request
# events but only for the master branch
on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]

# A workflow run is made up of one or more jobs that can run sequentially or in parallel
jobs:
  # This workflow contains a single job called "build"
  build:
    # The type of runner that the job will run on
    runs-on: ubuntu-latest

    # Steps represent a sequence of tasks that will be executed as part of the job
    steps:
    # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it
    - uses: actions/checkout@v2

    # Runs a single command using the runners shell
    - name: Run a one-line script
      run: echo Hello, world!

    # Runs a set of commands using the runners shell
    - name: Run a multi-line script
      run: |
        echo Add other actions to build,
        echo test, and deploy your project.
```



* Workflows Comunitarios (Es similar al sistema de Modulos en Terraform)

  * Hay workflows públicos que son creados por la comunidad y están públicos en el marketplace

    Repo oficial: https://github.com/marketplace?type=actions

    Repo independiente Netlify: https://github-actions.netlify.app



____

### Testing Matrix

Esta opción es interesante si tenemos un job en por ej node, y queremos testearlo con diferentes versiones, por ej 8, 10 y 12, y a su vez con distintos OS, como Ubuntu, Windows y macOs. 

A la vez también podríamos agregar los test sincronizados con distintas versiones de MongoDB.



____

### Ventajas

* Corre Docker consecutivos, es simplemente `docker build` y `docker run`
* Los `actions` en un `workflow` son isolados por default, por esta razón se puede usar un environment diferente para cada caso, por ej uno para compilación, y otro para testing (otros corren todos los `stages` en el mismo environment)
* Hay reimplementacion Open Source de Github Actions, como **act** para local testing
* Hay disponible acceso y autentifican a GitHub API de manera muy fácil
* Comunidad muy activa donde se comparten los `actions`
* Permite self-hosted runners, por lo cual se puede crear uno con mas recursos de hardware o ciertas configuraciones de seguridad especificas
* Los Jobs pueden correr en un container Docker (como otros), pero también pueden correr directamente en vms



____

### Desventajas

* No tiene cache nativo, si necesitas buildear artifacts hay que crear un cache externo
* La documentación oficial se podría mejorar, no hay mucha documentación de `best practices`
* No tiene una forma fácil/nativa de hacer unit-test actions
* Los `Actions` corren en contextos distintos isolados, esto puede complicar para dejar artifacts para una tarea próxima, se tiene que configurar un server de artifacts, o usar una especie de filesystem compartido que tienen
* No tiene una funcionalidad nativa para disparar un trigger manualmente 
* No tiene una funcionalidad nativa para manual approval

_Los dos últimos fueron solucionados hace pocos dias_ 
https://github.blog/changelog/2020-07-06-github-actions-manual-triggers-with-workflow_dispatch



____

### Pruebas Demo Workflows

* Probar generar una nuevo branch con un PR, y ver que pasa con el Workflow de Linter
* Realizar un tag de una version > 1 para verificar la compilación del Docker file y push a ECR
* Generar un nuevo cambio, para que se dispare el workflow de testing-matrix
