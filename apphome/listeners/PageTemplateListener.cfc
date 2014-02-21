<cfcomponent displayname="PageTemplateListener"	extends="MachII.framework.Listener"	output="false">

	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Configures the listener.">
		<!--- Put custom configuration for this listener here. --->
	</cffunction>

	<cffunction name="getPortfolio" output="false" access="public" returntype="array">
		<cfargument name="event" type="MachII.framework.Event" required="true" />

		<cfset LOCAL = {} />
		<cfset LOCAL.PageTemplateService = getProperty("serviceFactory").getBean('PageTemplateService') />

		<cfset LOCAL.PageTemplates = LOCAL.PageTemplateService.getPortfolio() />
		
		<cfreturn LOCAL.PageTemplates />
	</cffunction>
	
	<cffunction name="getPageTemplate" output="false" access="public" returntype="apphome.model.PageTemplate">
		<cfargument name="event" type="MachII.framework.Event" required="true" />

		<cfset LOCAL = {} />
		<cfset LOCAL.PageTemplateService = getProperty("serviceFactory").getBean('PageTemplateService') />

		<cfif ARGUMENTS.event.getArg("PTID") EQ ''>
			<cfset ARGUMENTS.event.setArg("PTID", 7111) />
		</cfif>

		<cfset LOCAL.PageTemplate = LOCAL.PageTemplateService.getPageTemplate(ID = ARGUMENTS.event.getArg("PTID")) />
		
		<cfreturn LOCAL.PageTemplate />
	</cffunction>

	<cffunction name="savePageTemplate" output="false" access="public" returntype="boolean">
		<cfargument name="event" type="MachII.framework.Event" required="true" />

		<cfset LOCAL = {} />
		<cfset LOCAL.PageTemplateService = getProperty("serviceFactory").getBean('PageTemplateService') />
		<cfset LOCAL.PageTemplate = LOCAL.PageTemplateService.getPageTemplate(ID = ARGUMENTS.event.getArg("PTID")) />

		<cfset LOCAL.PageTemplate.setID(ARGUMENTS.event.getArg("PTID")) />
		<cfset LOCAL.PageTemplate.setTitle(ARGUMENTS.event.getArg("Title")) />
		<cfset LOCAL.PageTemplate.setDescription(ARGUMENTS.event.getArg("Description")) />
		<cfset LOCAL.PageTemplate.setCost(ARGUMENTS.event.getArg("Cost")) />
		<cfset LOCAL.PageTemplate.setSmallPic(ARGUMENTS.event.getArg("SmallPic")) />
		<cfset LOCAL.PageTemplate.setLargePic(ARGUMENTS.event.getArg("LargePic")) />

		<cfset LOCAL.saveRes = LOCAL.PageTemplateService.savePageTemplate(PageTemplate = LOCAL.PageTemplate) />
		
		<cfreturn LOCAL.saveRes />
	</cffunction>

	<cffunction name="deletePageTemplate" output="false" access="public" returntype="boolean">
		<cfargument name="event" type="MachII.framework.Event" required="true" />

		<cfset LOCAL.PageTemplateService = getProperty("serviceFactory").getBean('PageTemplateService') />
		<cfset LOCAL.PageTemplate = ARGUMENTS.event.getArg("PageTemplate") />

		<cfset LOCAL.DeleteRes = LOCAL.PageTemplateService.deletePageTemplate(LOCAL.PageTemplate) />

		<cfreturn LOCAL.DeleteRes />
	</cffunction>

</cfcomponent>