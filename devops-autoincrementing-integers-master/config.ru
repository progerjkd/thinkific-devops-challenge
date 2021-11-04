# This file is used by Rack-based servers to start the application.
require 'rack'
require 'prometheus/middleware/collector'
require 'prometheus/middleware/exporter'

require_relative 'config/environment'

use Rack::Deflater
use Prometheus::Middleware::Collector
use Prometheus::Middleware::Exporter

run Rails.application
