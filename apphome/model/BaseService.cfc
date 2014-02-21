<cfcomponent output="false">	
	<cffunction name="init">
		<cfreturn this />
	</cffunction>

	<cffunction	name="OnMissingMethod" access="public" returntype="any"	output="false">
		<cfargument name="missingMethodName" type="string" required="true" />	 
		<cfargument name="missingMethodArguments" type="struct"	required="true"	/>	 

	 	<cfset var LOCAL = {} />
		<cfset LOCAL.entityName = "" />

		<!--- Dynamic getFooQuery() method --->
		<cfif Left( missingMethodName, 3 ) EQ "get" AND Right( missingMethodName, 5 ) EQ "query">		
			<cfset LOCAL.entityName = Mid( arguments.missingMethodName, 4, Len( arguments.missingMethodName)- Len("getquery") ) />
			<cfreturn variables[ LOCAL.entityName & "Gateway" ].getByAttributesQuery(argumentCollection=arguments.missingMethodArguments) />
		
		<!--- Dynamic getFooArray() method --->
		<cfelseif Left( missingMethodName, 3 ) EQ "get" AND Right( missingMethodName, 5 ) EQ "array">		
			<cfset LOCAL.entityName = Mid( arguments.missingMethodName, 4, Len( arguments.missingMethodName)- Len("getarray") ) />
			<cfreturn variables[ LOCAL.entityName & "Gateway" ].getByAttributes(argumentCollection=arguments.missingMethodArguments) />
		
		<!--- Implicit getter --->
		<cfelseif Left( arguments.missingMethodName, 3 ) EQ "get" AND structIsEmpty( arguments.missingMethodArguments ) >
			<cfset LOCAL.key = Right( arguments.missingMethodName, Len( arguments.missingMethodName )-3) >
			<cfreturn variables[ LOCAL.key ] />
		
		<!--- Implicit setter --->
		<cfelseif Left( arguments.missingMethodName, 3 ) eq "set" AND StructCount( arguments.missingMethodArguments) EQ 1>
			<cfset LOCAL.key = Right( arguments.missingMethodName, Len( arguments.missingMethodName )-3) >			
			<cfif StructKeyExists( arguments.missingMethodArguments, LOCAL.key )>
				<cfset variables[ LOCAL.key ] = arguments.missingMethodArguments[ LOCAL.key ] />
			<cfelse>
				<cfset variables[ LOCAL.key ] = arguments.missingMethodArguments[ 1 ] />
			</cfif> 
			<cfreturn />
		</cfif>	 
		<cfreturn />
	</cffunction>


	<cffunction name="queryRowToStruct" access="private" output="false" returntype="struct">
		<cfargument name="query" type="query" required="true">
		
		<cfset var LOCAL = {} />

		<cfset LOCAL.cols= ListToArray( ARGUMENTS.query.columnList ) />
		<cfset LOCAL.result = {} />
		<cfset LOCAL.row = 1 />

		<cfif ArrayLen( ARGUMENTS ) GT 1>
			<cfset LOCAL.row = ARGUMENTS[ 2 ] />
		</cfif>

		<cfloop from="1" to="#ArrayLen( LOCAL.cols )#" index="LOCAL.i">
			<cfset LOCAL.result[ LOCAL.cols[ LOCAL.i ] ] = ARGUMENTS.query[ LOCAL.cols[ LOCAL.i ] ][ LOCAL.row ] />
		</cfloop>

		<cfreturn LOCAL.result />
	</cffunction>
</cfcomponent> 