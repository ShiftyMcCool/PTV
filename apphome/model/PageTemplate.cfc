<cfcomponent displayname="PageTemplate" output="false">
	<cfproperty name="ID" type="string" default="" />
	<cfproperty name="Title" type="string" default="" />
	<cfproperty name="Description" type="string" default="" />
	<cfproperty name="Cost" type="numeric" default="0" />
	<cfproperty name="SmallPic" type="string" default="" />
	<cfproperty name="LargePic" type="string" default="" />

	<cfset variables.instance = StructNew() />

	<cffunction name="init" access="public" returntype="apphome.model.PageTemplate" output="false">
		<cfargument name="ID" type="string" required="false" default="" />
		<cfargument name="Title" type="string" required="false" default="" />
		<cfargument name="Description" type="string" required="false" default="" />
		<cfargument name="Cost" type="numeric" required="false" default="0" />
		<cfargument name="SmallPic" type="string" required="false" default="" />
		<cfargument name="LargePic" type="string" required="false" default="" />

		<cfset setID(arguments.ID) />
		<cfset setTitle(arguments.Title) />
		<cfset setDescription(arguments.Description) />
		<cfset setCost(arguments.Cost) />
		<cfset setSmallPic(arguments.SmallPic) />
		<cfset setLargePic(arguments.LargePic) />

		<cfreturn this />
	</cffunction>

	<cffunction name="setID" access="public" returntype="void" output="false">
		<cfargument name="ID" type="string" required="true" />
		<cfset variables.instance.ID = arguments.ID />
	</cffunction>
	<cffunction name="getID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ID />
	</cffunction>

	<cffunction name="setTitle" access="public" returntype="void" output="false">
		<cfargument name="Title" type="string" required="true" />
		<cfset variables.instance.Title = arguments.Title />
	</cffunction>
	<cffunction name="getTitle" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Title />
	</cffunction>

	<cffunction name="setDescription" access="public" returntype="void" output="false">
		<cfargument name="Description" type="string" required="true" />
		<cfset variables.instance.Description = arguments.Description />
	</cffunction>
	<cffunction name="getDescription" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Description />
	</cffunction>

	<cffunction name="setCost" access="public" returntype="void" output="false">
		<cfargument name="Cost" type="numeric" required="true" />
		<cfset variables.instance.Cost = arguments.Cost />
	</cffunction>
	<cffunction name="getCost" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Cost />
	</cffunction>

	<cffunction name="setSmallPic" access="public" returntype="void" output="false">
		<cfargument name="SmallPic" type="string" required="true" />
		<cfset variables.instance.SmallPic = arguments.SmallPic />
	</cffunction>
	<cffunction name="getSmallPic" access="public" returntype="string" output="false">
		<cfreturn variables.instance.SmallPic />
	</cffunction>

	<cffunction name="setLargePic" access="public" returntype="void" output="false">
		<cfargument name="LargePic" type="string" required="true" />
		<cfset variables.instance.LargePic = arguments.LargePic />
	</cffunction>
	<cffunction name="getLargePic" access="public" returntype="string" output="false">
		<cfreturn variables.instance.LargePic />
	</cffunction>
</cfcomponent>