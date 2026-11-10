#ifndef PROFILES_FILE
#define PROFILES_FILE

#define TRUE_DARKNESS

#ifdef TRUE_DARKNESS
	#ifndef MOON_PHASE_INF_ATMOSPHERE
		#define MOON_PHASE_INF_ATMOSPHERE
	#endif
	#if defined MOON_PHASE_DARK
		#undef MOON_PHASE_DARK
		#define MOON_PHASE_DARK 0.01
	#else
		#define MOON_PHASE_DARK 0.01
	#endif
	#if defined MOON_PHASE_PARTIAL
		#undef MOON_PHASE_PARTIAL
		#define MOON_PHASE_PARTIAL 0.15
	#else
		#define MOON_PHASE_PARTIAL 0.15
	#endif
	#ifndef MOON_PHASE_INF_LIGHT
		#define MOON_PHASE_INF_LIGHT
	#endif
	#if defined MOON_PHASE_FULL
		#undef MOON_PHASE_FULL
		#define MOON_PHASE_FULL 0.45
	#else
		#define MOON_PHASE_FULL 0.45
	#endif
	#if defined CAVE_LIGHTING
		#undef CAVE_LIGHTING
		#define CAVE_LIGHTING 0
	#else
		#define CAVE_LIGHTING 0
	#endif
#endif

#endif