# Globus Map

This project shall display a map of germany, stripped down to community level,
where the next globus supermarket is. This is due to the fact that i really
love Leberkaesebroetchen for 1 Euro from globus and I wanted to know how far
the next one is based on where people are living

## Installation

The simplest way do have working setup is to use ``docker-compose``:

```sh
docker-compose up --build
```

Afterwards, the server is available at ``http://localhost:54721``.

## Directory structure

```
.
├── apps (real visualiziation apps like notebooks)
├── data
│   ├── external (data from external sources)
│   ├── interim (data preprocessed but not ready for visualization yet)
│   └── processed (finished processed data used for visualization
├── processing (notebooks used to process and prepare data)
└── ... (all other default top-levelfiles)
```

Note: Not all ``external`` data is checked in due to size contraints,
see the ``README.md`` in ``data`` for details.

## Limitations:

* Not every globus has a Leberkaesebroetchen for 1 Euro, but it is not easy
  to find out which one have and which not. Therefore, it shows
  all globus (which is an overapproximation)
