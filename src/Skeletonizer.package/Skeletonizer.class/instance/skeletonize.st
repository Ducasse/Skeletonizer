operations
skeletonize
	selectors do: [ :each | self skeletonizeMethod: each ].
	classSelectors do: [ :each | self skeletonizeClassMethod: each ].