<cfcomponent displayname="PageTemplateGateway" output="false" extends="apphome.model.BaseService">
	<cffunction name="init" access="public" output="false" returntype="apphome.model.PageTemplateGateway">
		<cfreturn this />
	</cffunction>

	<cffunction name="getPortfolio" access="public" output="false" returntype="any">
		<cfset var LOCAL = {} />
		<cfset LOCAL.retVal = {} />
		<cfset LOCAL.Portfolio = [] />

		<cffile action="read" file="E:\Websites\mentorgraphics\xml\PageTemplatePortfolio.xml" variable="LOCAL.ptxml">

		<cfset LOCAL.pageTemplates = XmlParse(LOCAL.ptxml)>

		<cfset LOCAL.PortfolioData = xmlSearch(LOCAL.pageTemplates, "/portfolio/pagetemplate") />

		<cfloop array="#LOCAL.PortfolioData#" index="LOCAL.x">
			<cfset LOCAL.PageTemplateData.ID = LOCAL.x.ID.xmltext />
			<cfset LOCAL.PageTemplateData.Title = LOCAL.x.title.xmltext />
			<cfset LOCAL.PageTemplateData.Description = LOCAL.x.description.xmltext />
			<cfset LOCAL.PageTemplateData.Cost = LOCAL.x.cost.xmltext />
			<cfset LOCAL.PageTemplateData.SmallPic = LOCAL.x.smallpic.xmltext />
			<cfset LOCAL.PageTemplateData.LargePic = LOCAL.x.largepic.xmltext />

			<cfset arrayAppend(LOCAL.Portfolio, structCopy(LOCAL.PageTemplateData)) />
		</cfloop>

		<cfreturn LOCAL.Portfolio />
	</cffunction>
</cfcomponent>