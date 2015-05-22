all: memory_optimization

memory_optimization:
	rvm use 1.9.3
	ruby memprof_app.rb MEMORY
	ruby memprof_app_optimized.rb MEMORY
	ruby memprof_app.rb ALLOCATIONS
	ruby memprof_app_optimized.rb ALLOCATIONS
	ruby memprof_app.rb GC_RUNS
	ruby memprof_app.rb GC_STATS
