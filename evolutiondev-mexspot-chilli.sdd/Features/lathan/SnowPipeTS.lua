local objectname= "SnowPipeTS" 
local featureDef	=	{
	name			= "SnowPipeTS",
	world				="allworld",
	description				="SnowyPipe",
	category				="SnowyPipes",
	object				="features/lathan/SnowPipeTS.s3o",
	footprintx				=4,
	footprintz				=7,
	height				=78,
	blocking				=true,
	upright				=true,
	hitdensity				=5,
	energy = 10,
-- energy				=0,
	metal = 0,
--metal				=220,
	damage				=900,
	flammable				=false,
	reclaimable				=true,
	autoreclaimable				=true,
	featurereclamate				="smudge01",
	seqnamereclamate				="tree1reclamate",
	customparams = { 
		randomrotate		= "true", 
	}, 
}
return lowerkeys({[objectname] = featureDef}) 
