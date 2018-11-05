BACKEND = 'frontera.contrib.backends.sqlalchemy.FIFO'
#BACKEND='frontera.contrib.backends.CommonBackend'
SQLALCHEMYBACKEND_ENGINE = 'sqlite:///hn_frontier.db'
MAX_REQUESTS = 50
MAX_NEXT_REQUESTS = 10
DELAY_ON_EMPTY = 0.0


SQLALCHEMYBACKEND_REVISIT_INTERVAL=1
CANONICAL_SOLVER='frontera.contrib.canonicalsolvers.Basic'
BC_MAX_REQUESTS_PER_HOST=100
CRAWLING_STRATEGY='frontera.worker.strategies.bfs'
