-- ============================================================================
-- TICKET-ADV007: Monthly range partitioning for trades table
-- ============================================================================

CREATE TABLE trades (
    id              BIGSERIAL,
    trade_ref       VARCHAR(30) NOT NULL,
    instrument_id   BIGINT NOT NULL,
    counterparty_id BIGINT NOT NULL,
    asset_class     VARCHAR(20) NOT NULL,
    side            VARCHAR(4) NOT NULL,
    quantity        NUMERIC(18,4) NOT NULL,
    price           NUMERIC(18,4) NOT NULL,
    trade_date      DATE NOT NULL,
    status          VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    deleted_at      TIMESTAMPTZ,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    modified_at     TIMESTAMPTZ,

    PRIMARY KEY (id, trade_date)
)
PARTITION BY RANGE (trade_date);


-- Monthly partitions: April - July 2026

CREATE TABLE trades_y2026m04
PARTITION OF trades
FOR VALUES FROM ('2026-04-01') TO ('2026-05-01');


CREATE TABLE trades_y2026m05
PARTITION OF trades
FOR VALUES FROM ('2026-05-01') TO ('2026-06-01');


CREATE TABLE trades_y2026m06
PARTITION OF trades
FOR VALUES FROM ('2026-06-01') TO ('2026-07-01');


CREATE TABLE trades_y2026m07
PARTITION OF trades
FOR VALUES FROM ('2026-07-01') TO ('2026-08-01');


-- Safety catch-all partition

CREATE TABLE trades_default
PARTITION OF trades DEFAULT;


-- Indexes inherited by partitions

CREATE INDEX idx_trades_status
ON trades(status);

CREATE INDEX idx_trades_instrument
ON trades(instrument_id);

CREATE INDEX idx_trades_counterparty
ON trades(counterparty_id);