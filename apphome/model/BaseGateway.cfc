<cfcomponent output="false">	

	<cffunction	name="OnMissingMethod" access="public" returntype="any"	output="false">
		<cfargument name="missingMethodName" type="string" required="true" />	 
		<cfargument name="missingMethodArguments" type="struct"	required="true"	/>	 

	 	<cfset var LOCAL = {} />
		<cfset LOCAL.entityName = "" />

		<!--- Implicit getter --->
		<cfif Left( arguments.missingMethodName, 3 ) EQ "get" AND structIsEmpty( arguments.missingMethodArguments ) >
			<cfset LOCAL.key = Right( arguments.missingMethodName, Len( arguments.missingMethodName )-3) >
			<cfreturn variables[ LOCAL.key ] />
		
		<!--- Implicit setter --->
		<cfelseif Left( arguments.missingMethodName, 3 ) eq "set" AND StructCount( arguments.missingMethodArguments) EQ 1>
			<cfset LOCAL.key = Right( arguments.missingMethodName, Len( arguments.missingMethodName )-3) >			
			<cfif StructKeyExists( arguments.missingMethodArguments, LOCAL.key )>
				<cfset variables[ LOCAL.key ] = arguments.missingMethodArguments[ LOCAL.key ] />
			<cfelse>
				<cfset variables[ LOCAL.key ] = arguments.arguments.missingMethodArguments[ 1 ] />
			</cfif> 
			<cfreturn />
		</cfif>	 
		<cfreturn />
	</cffunction>

</cfcomponent> 