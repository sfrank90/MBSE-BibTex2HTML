/*
 * generated by Xtext
 */
package de.tubs.bibtextohtml.htmlgenerator.generator

import de.tubs.bibtextohtml.htmlgenerator.hTMLGenerator.RunModule

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IFileSystemAccess
import org.eclipse.xtext.generator.IGenerator
import org.eclipse.core.resources.ResourcesPlugin
import de.tubs.bibtextohtml.htmlgenerator.hTMLGenerator.PrefixOption
import de.tubs.bibtextohtml.htmlgenerator.hTMLGenerator.Import
import de.tubs.bibtextohtml.htmlgenerator.hTMLGenerator.Styles
import org.eclipse.core.resources.IFolder
import org.eclipse.core.runtime.Path
import java.nio.file.Files
import java.nio.file.Paths
import java.nio.charset.Charset
import java.io.FileNotFoundException
import de.tubs.bibtextohtml.bibtex.bibTeX.Model
import org.eclipse.xtext.util.StringInputStream
import de.tubs.bibtextohtml.bibtex.bibTeX.BibtexEntryTypes
import java.io.InputStream
import java.io.InputStreamReader
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl
import org.eclipse.emf.ecore.resource.ResourceSet
import de.tubs.bibtextohtml.bibtex.bibTeX.AuthorField
import de.tubs.bibtextohtml.bibtex.bibTeX.TitleField
import de.tubs.bibtextohtml.bibtex.bibTeX.YearField
import de.tubs.bibtextohtml.htmlgenerator.hTMLGenerator.BibTexStyle
import de.tubs.bibtextohtml.bibtex.bibTeX.Article
import de.tubs.bibtextohtml.bibtex.bibTeX.JournalField
import de.tubs.bibtextohtml.bibtex.bibTeX.NumberField
import de.tubs.bibtextohtml.bibtex.bibTeX.PagesField
import de.tubs.bibtextohtml.bibtex.bibTeX.MonthField
import de.tubs.bibtextohtml.bibtex.bibTeX.VolumeField
import de.tubs.bibtextohtml.bibtex.bibTeX.NoteField
import de.tubs.bibtextohtml.bibtex.bibTeX.Book
import de.tubs.bibtextohtml.bibtex.bibTeX.Conference
import de.tubs.bibtextohtml.bibtex.bibTeX.Manual
import de.tubs.bibtextohtml.bibtex.bibTeX.Inproceedings
import de.tubs.bibtextohtml.bibtex.bibTeX.EditorField
import de.tubs.bibtextohtml.bibtex.bibTeX.PublisherField
import de.tubs.bibtextohtml.bibtex.bibTeX.SeriesField
import de.tubs.bibtextohtml.bibtex.bibTeX.IsbnField
import de.tubs.bibtextohtml.bibtex.bibTeX.AddressField
import de.tubs.bibtextohtml.bibtex.bibTeX.EditionField
import java.io.IOException
//import org.eclipse.emf.ecore.resource.Resource.Diagnostic
import org.eclipse.emf.ecore.util.Diagnostician
import org.eclipse.emf.common.util.Diagnostic
import java.io.File
import java.util.List
import java.io.FilenameFilter
import java.util.ArrayList
import de.tubs.bibtextohtml.bibtex.bibTeX.OrganizationField
import de.tubs.bibtextohtml.bibtex.bibTeX.BooktitleField
import java.util.Comparator
import de.tubs.bibtextohtml.htmlgenerator.hTMLGenerator.SortingOption
import de.tubs.bibtextohtml.htmlgenerator.hTMLGenerator.OptionSet
import de.tubs.bibtextohtml.htmlgenerator.hTMLGenerator.SortBy
import de.tubs.bibtextohtml.htmlgenerator.hTMLGenerator.CategoryOption
import de.tubs.bibtextohtml.htmlgenerator.hTMLGenerator.CategorySortBy
import de.tubs.bibtextohtml.bibtex.bibTeX.URLField
import de.tubs.bibtextohtml.htmlgenerator.hTMLGenerator.FontColor

/**
 * Generates code from your model files on save.
 * 
 * see http://www.eclipse.org/Xtext/documentation.html#TutorialCodeGeneration
 */
class HTMLGeneratorGenerator implements IGenerator {
	var numCounter = 1

	def compile(RunModule module, Model _bibRes) '''	
			«var pre = (module.getModule().eAllContents().toIterable().filter(typeof(PrefixOption)).get(0) as PrefixOption).
			prefix»
			«var printShortcut = (module.getModule().bibtexStyle)»
			<!DOCTYPE html>

			<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
			<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
			<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
			
			<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
			
			<head>
				<meta charset="UTF-8">
				
				<!-- Remove this line if you use the .htaccess -->
				<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
				
				<title>«(module.getModule().elements.filter(typeof(Import)).get(0) as Import).importBibtex»</title>
				
				<style>
				«FOR styles : module.getModule().eAllContents().toIterable().filter(typeof(Styles))»
					«styles.printStyles(pre)»
				«ENDFOR»
				</style>
				
				<link href='http://fonts.googleapis.com/css?family=Open+Sans:400italic,400,700' rel='stylesheet' type='text/css'>
				<link rel="stylesheet" href="css/style.css">
				
				<!--[if lt IE 9]>
				<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
				<![endif]-->
			</head>
			
			<body>
			<!-- Prompt IE 7 users to install Chrome Frame -->
			<!--[if lt IE 8]><p class=chromeframe>Your browser is <em>ancient!</em> <a href="http://browsehappy.com/">
			Upgrade to a different browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">install Google Chrome Frame</a> to experience this site.</p><![endif]-->
			
			<div class="container">
			
				<header id="navtop" style="margin-top: -4em">
					<a href="index.html" class="logo fleft">
						<img src="img/bibhtml.png" alt="Startsite">
					</a>
					
					<nav class="fright">
					</nav>
				</header>
			
			
			<div class="home-page main">
				<section class="grid-wrap" >
					<header class="grid col-full" style="text-align: center">
						<hr>
						<h1 >References</h1>
					</header>				
					 
					«var curValue = ""»
					«var printCategory = false»
					«val optionSet = module.getModule().eAllContents().toIterable.filter(typeof(OptionSet)).get(0) as OptionSet»
					
					«if(!optionSet.eContents.filter(typeof(CategoryOption)).empty) { printCategory = true; ""}»
					
					«FOR BibtexEntryTypes entry : sortedEntrySet(_bibRes, optionSet)»
						«var newVal = ""»
						«if(printCategory && (optionSet.eAllContents.toIterable.filter(typeof(CategorySortBy)).get(0) as CategorySortBy).year
							&& entry.eContents.filter(YearField).size > 0) { 
							newVal = (entry.eContents.filter(YearField).get(0) as YearField).year; ""
						}»
						«if(printCategory && (optionSet.eAllContents.toIterable.filter(typeof(CategorySortBy)).get(0) as CategorySortBy).author
							&& entry.eContents.filter(AuthorField).size > 0) { 
							val HTMLParserHelper.Author firstAuthor = HTMLParserHelper.parseAuthors((entry.eContents.filter(AuthorField).get(0) as AuthorField).authors).get(0)
							newVal = firstAuthor.lastname + ", " + firstAuthor.firstname; ""
						}»						 
						«IF (printCategory && !newVal.equals("") && !newVal.equals(curValue))»
							<section class="grid col-full">
								<b>«curValue = newVal»</b>
							</section>
						«ENDIF»
						«entry.printAll(pre, printShortcut)»
						<section class="grid col-full">
						</section>
					«ENDFOR»
				</section>				
			   
			</div> <!--main-->
			
			
			</div><!--container-->
			
			<!-- Javascript - jQuery -->
			<script src="http://code.jquery.com/jquery.min.js"></script>
			<script>window.jQuery || document.write('<script src="js/jquery-1.7.2.min.js"><\/script>')</script>
			
			<!--[if (gte IE 6)&(lte IE 8)]>
			<script src="js/selectivizr.js"></script>
			<![endif]-->
			
			<script src="js/jquery.flexslider-min.js"></script>
			<script src="js/scripts.js"></script>
			
			</body>
			</html>			
	'''

	def compile(Import imp) '''
		«imp.importBibtex»
	'''

	def printStyles(Styles styles, String pre) '''
		.«pre»«IF !styles.isWildcard»«styles.attributeType»«ELSEIF styles.wildcard»*«ENDIF» {
			font-type: «styles.fontType»;
			«IF styles.fontStyles.isBold»font-weight: bold;«ENDIF»
			«IF styles.fontStyles.isItalic»font-style: italic;«ENDIF»
			«IF styles.fontStyles.isUnderlined»text-decoration: underline;«ENDIF»
			«IF (styles.eContents.filter(FontColor).size > 0)»color: «(styles.eContents.filter(FontColor).get(0) as FontColor).color»;«ENDIF»
		}
	'''
	
	def printShortcut(BibtexEntryTypes entry, BibTexStyle style) {
		var shortcut = ""
		var authors = HTMLParserHelper.parseAuthors((entry.eContents.filter(AuthorField).get(0) as AuthorField).authors)
		var year = (entry.eContents.filter(YearField).get(0) as YearField).year

		switch style {
			case style.isALPAHNUM: {
				for (a : authors) {
					var name = a.lastname
					var firstChar = String.valueOf(name.charAt(0))
					shortcut += firstChar
				}
				var yearStr = year.toString
				shortcut += String.valueOf(yearStr.charAt(0)) + String.valueOf(yearStr.charAt(1))
				return "[" + shortcut + "]"
			}
			case style.isNUM: {
				return "[" + numCounter++ + "]"
			}
			default:
				return shortcut
		}
	}

	// Different templates to print entries
	//note: we've to check wether these elements exist...
	def printAll(BibtexEntryTypes entry, String pre, BibTexStyle style) ''' 
		«if(entry instanceof Article) {entry.printArticle(pre, style)}»
		«if(entry instanceof Book) {entry.printBook(pre, style)}»
		«if(entry instanceof Conference) {entry.printConference(pre, style)}»
		«if(entry instanceof Manual) {entry.printManual(pre, style)}»
		«if(entry instanceof Inproceedings) {entry.printInProceeding(pre, style)}»
	'''
	
	def printArticle(BibtexEntryTypes entry, String pre, BibTexStyle style) '''
		«var authors = HTMLParserHelper.parseAuthors((entry.eContents.filter(AuthorField).get(0) as AuthorField).authors)»
		<!-- begin: entry for article -->		
		<aside class="grid col-one-quarter mq2-col-one-third mq3-col-full" style="text-align: right">
			«entry.printShortcut(style)»
		</aside>
			
		
		 <section class="grid col-three-quarters mq2-col-two-thirds mq3-col-full">
			<div>
			   	<span class="«pre»author">
				   	«FOR a : authors»
						«a.firstname» «a.lastname» «IF authors.indexOf(a) != (authors.size() - 1)» and «ENDIF»
					«ENDFOR»
				</span>. 
			   <span class="«pre»title">«(entry.eContents.filter(TitleField).get(0) as TitleField).title»</span>.
			   <span class="«pre»journal"><i>«(entry.eContents.filter(JournalField).get(0) as JournalField).journal»</i></span>, 
			   «IF (entry.eContents.filter(VolumeField).size > 0)»<span class="«pre»volume">«(entry.eContents.filter(VolumeField).get(0) as VolumeField).volume»</span>«ENDIF»
			   		«IF (entry.eContents.filter(NumberField).size > 0)»(<span class="«pre»number">«(entry.eContents.filter(NumberField).get(0) as NumberField).number»</span>):«ENDIF»
			   		«IF (entry.eContents.filter(PagesField).size > 0)»<span class="«pre»pages">«(entry.eContents.filter(PagesField).get(0) as PagesField).pages»</span>«ENDIF», 
			   «IF (entry.eContents.filter(MonthField).size > 0)»<span class="«pre»month">«(entry.eContents.filter(MonthField).get(0) as MonthField).month»</span>«ENDIF»
			   <span class="«pre»year">«(entry.eContents.filter(YearField).get(0) as YearField).year»</span>. 
			   «IF (entry.eContents.filter(NoteField).size > 0)»<span class="«pre»note">«(entry.eContents.filter(NoteField).get(0) as NoteField).note»</span>.«ENDIF»
			   «IF (entry.eContents.filter(URLField).size > 0)»<br/>URL: <a href="«(entry.eContents.filter(URLField).get(0) as URLField).url»" class="«pre»url" style="color:black;"><i>
			   		«(entry.eContents.filter(URLField).get(0) as URLField).url»</i></a>.«ENDIF»
			</div>
		 </section>
		 <!-- end: entry for article -->
 	'''
 	
 	def printBook(BibtexEntryTypes entry, String pre, BibTexStyle style) '''
		<!-- begin: entry for book -->		
		<aside class="grid col-one-quarter mq2-col-one-third mq3-col-full" style="text-align: right">
			«entry.printShortcut(style)»
		</aside>
			
		
		 <section class="grid col-three-quarters mq2-col-two-thirds mq3-col-full">
			<div>
			   «IF (entry.eContents.filter(AuthorField).size > 0)»
			   		«var authors = HTMLParserHelper.parseAuthors((entry.eContents.filter(AuthorField).get(0) as AuthorField).authors)»
			   		<span class="«pre»author editor">
			   		«FOR a : authors»
						«a.firstname» «a.lastname» «IF authors.indexOf(a) != (authors.size() - 1)» and «ENDIF»
					«ENDFOR»</span>. 
				«ELSEIF (entry.eContents.filter(EditorField).size > 0)»<span class="«pre»editor">«(entry.eContents.filter(EditorField).get(0) as EditorField).editor»</span>
				«ENDIF»
			   <span class="«pre»title"><i>«(entry.eContents.filter(TitleField).get(0) as TitleField).title»</i></span>,
			   «IF (entry.eContents.filter(VolumeField).size > 0)»
			   		<span class="«pre»volume">volume «(entry.eContents.filter(VolumeField).get(0) as VolumeField).volume» of</span>  
		   		«ELSEIF (entry.eContents.filter(NumberField).size > 0)»<span class="«pre»number">number «(entry.eContents.filter(NumberField).get(0) as NumberField).number» of</span>
		   		«ENDIF»
		   	   «IF (entry.eContents.filter(SeriesField).size > 0)»<span class="«pre»series">«(entry.eContents.filter(SeriesField).get(0) as SeriesField).series».«ENDIF»
			   <span class="«pre»publisher">«(entry.eContents.filter(PublisherField).get(0) as PublisherField).publisher»</span>, 
			   «IF (entry.eContents.filter(AddressField).size > 0)»<span class="«pre»address">«(entry.eContents.filter(AddressField).get(0) as AddressField).address»</span>, «ENDIF»
			   «IF (entry.eContents.filter(EditionField).size > 0)»<span class="«pre»edition">«(entry.eContents.filter(EditionField).get(0) as EditionField).edition» </span>edition, «ENDIF»
			   «IF (entry.eContents.filter(MonthField).size > 0)»<span class="«pre»month">«(entry.eContents.filter(MonthField).get(0) as MonthField).month»</span> «ENDIF»
			   «IF (entry.eContents.filter(YearField).size > 0)»<span class="«pre»year">«(entry.eContents.filter(YearField).get(0) as YearField).year»</span>. «ENDIF»
			   «IF (entry.eContents.filter(IsbnField).size > 0)»ISBN <span class="«pre»isbn"><i>«(entry.eContents.filter(IsbnField).get(0) as IsbnField).isbn»</i></span>.«ENDIF»
			   «IF (entry.eContents.filter(NoteField).size > 0)»<span class="«pre»note">«(entry.eContents.filter(NoteField).get(0) as NoteField).note»</span>.«ENDIF»
			   «IF (entry.eContents.filter(URLField).size > 0)»<br/>URL: <a href="«(entry.eContents.filter(URLField).get(0) as URLField).url»" class="«pre»url" style="color:black;"><i>
			   		«(entry.eContents.filter(URLField).get(0) as URLField).url»</i></a>.«ENDIF»
			</div>
		 </section>
		 <!-- end: entry for book -->
 	'''
 	
 	def printConference(BibtexEntryTypes entry, String pre, BibTexStyle style) '''
		<!-- begin: entry for Conference -->		
		<aside class="grid col-one-quarter mq2-col-one-third mq3-col-full" style="text-align: right">
			«entry.printShortcut(style)»
		</aside>
			
		
		 <section class="grid col-three-quarters mq2-col-two-thirds mq3-col-full">
			<div>
			   «var authors = HTMLParserHelper.parseAuthors((entry.eContents.filter(AuthorField).get(0) as AuthorField).authors)»
			   		<span class="«pre»author editor">
			   		«FOR a : authors»
						«a.firstname» «a.lastname» «IF authors.indexOf(a) != (authors.size() - 1)» and «ENDIF»
					«ENDFOR»</span>. 
			   <span class="«pre»title">«(entry.eContents.filter(TitleField).get(0) as TitleField).title»</span>. 
			   «IF (entry.eContents.filter(EditorField).size > 0)»In <span class="«pre»editor">«(entry.eContents.filter(EditorField).get(0) as EditorField).editor»</span>, editor,«ENDIF» 
			   <span class="«pre»booktitle"><i>«(entry.eContents.filter(BooktitleField).get(0) as BooktitleField).booktitle»</i></span>, 
			   «IF (entry.eContents.filter(VolumeField).size > 0)»
			   		volume <span class="«pre»volume">«(entry.eContents.filter(VolumeField).get(0) as VolumeField).volume»</span> 
		   		«ELSEIF (entry.eContents.filter(NumberField).size > 0)»
			   number <span class="«pre»number">«(entry.eContents.filter(NumberField).get(0) as NumberField).number»</span> 
		   		«ENDIF»
		   		«IF (entry.eContents.filter(SeriesField).size > 0)»of <span class="«pre»series">«(entry.eContents.filter(SeriesField).get(0) as SeriesField).series»</span>«ENDIF», 
		   		«IF (entry.eContents.filter(PagesField).size > 0)»page <span class="«pre»page">«(entry.eContents.filter(PagesField).get(0) as PagesField).pages»</span>, «ENDIF»
			   «IF (entry.eContents.filter(AddressField).size > 0)»<span class="«pre»address">«(entry.eContents.filter(AddressField).get(0) as AddressField).address»</span>, «ENDIF»
			   «IF (entry.eContents.filter(MonthField).size > 0)»<span class="«pre»month">«(entry.eContents.filter(MonthField).get(0) as MonthField).month»</span>«ENDIF» 
			   <span class="«pre»year">«(entry.eContents.filter(YearField).get(0) as YearField).year»</span>. 
			   «IF (entry.eContents.filter(OrganizationField).size > 0)»<span class="«pre»organization">«(entry.eContents.filter(OrganizationField).get(0) as OrganizationField).organization»</span>, «ENDIF»
			   «IF (entry.eContents.filter(PublisherField).size > 0)»<span class="«pre»publisher">«(entry.eContents.filter(PublisherField).get(0) as PublisherField).publisher»</span>. «ENDIF»
			   «IF (entry.eContents.filter(NoteField).size > 0)»<span class="«pre»note">«(entry.eContents.filter(NoteField).get(0) as NoteField).note»</span>.«ENDIF»
			   «IF (entry.eContents.filter(URLField).size > 0)»<br/>URL: <a href="«(entry.eContents.filter(URLField).get(0) as URLField).url»" class="«pre»url" style="color:black;"><i>
			   		«(entry.eContents.filter(URLField).get(0) as URLField).url»</i></a>.«ENDIF»
			</div>
		 </section>
		 <!-- end: entry for Conference -->
 	'''
 	
 	def printManual(BibtexEntryTypes entry, String pre, BibTexStyle style) '''
		<!-- begin: entry for Manual -->		
		<aside class="grid col-one-quarter mq2-col-one-third mq3-col-full" style="text-align: right">
			«entry.printShortcut(style)»
		</aside>
			
		
		<section class="grid col-three-quarters mq2-col-two-thirds mq3-col-full">
			<div>
			   «IF (entry.eContents.filter(AuthorField).size > 0)»
			   		«var authors = HTMLParserHelper.parseAuthors((entry.eContents.filter(AuthorField).get(0) as AuthorField).authors)»
			   		<span class="«pre»author editor">
			   		«FOR a : authors»
						«a.firstname» «a.lastname» «IF authors.indexOf(a) != (authors.size() - 1)» and «ENDIF»
					«ENDFOR»</span>. 
				«ENDIF»
			   <span class="«pre»title"><i>«(entry.eContents.filter(TitleField).get(0) as TitleField).title»</i></span>. 
			   «IF (entry.eContents.filter(OrganizationField).size > 0)»<span class="«pre»organization">«(entry.eContents.filter(OrganizationField).get(0) as OrganizationField).organization»</span>, «ENDIF»
			   <span class="«pre»address">«(entry.eContents.filter(AddressField).get(0) as AddressField).address»</span>, 
			   «IF (entry.eContents.filter(EditionField).size > 0)»<span class="«pre»edition">«(entry.eContents.filter(EditionField).get(0) as EditionField).edition»</span> edition, «ENDIF»
			   «IF (entry.eContents.filter(MonthField).size > 0)»<span class="«pre»month">«(entry.eContents.filter(MonthField).get(0) as MonthField).month»</span> «ENDIF»
			   <span class="«pre»year">«(entry.eContents.filter(YearField).get(0) as YearField).year»</span> 			    
			   «IF (entry.eContents.filter(NoteField).size > 0)»<span class="«pre»note">«(entry.eContents.filter(NoteField).get(0) as NoteField).note»</span>.«ENDIF»
			   «IF (entry.eContents.filter(URLField).size > 0)»<br/>URL: <a href="«(entry.eContents.filter(URLField).get(0) as URLField).url»" class="«pre»url" style="color:black;"><i>
			   		«(entry.eContents.filter(URLField).get(0) as URLField).url»</i></a>.«ENDIF»
			</div>
		 </section>
		 <!-- end: entry for Manual -->
 	'''
 	
 	def printInProceeding(BibtexEntryTypes entry, String pre, BibTexStyle style) '''
		<!-- begin: entry for InProceeding -->		
		<aside class="grid col-one-quarter mq2-col-one-third mq3-col-full" style="text-align: right">
			«entry.printShortcut(style)»
		</aside>
			
		
		 <section class="grid col-three-quarters mq2-col-two-thirds mq3-col-full">
			<div>
			   «var authors = HTMLParserHelper.parseAuthors((entry.eContents.filter(AuthorField).get(0) as AuthorField).authors)»
			   		<span class="«pre»author editor">
			   		«FOR a : authors»
						«a.firstname» «a.lastname» «IF authors.indexOf(a) != (authors.size() - 1)» and «ENDIF»
					«ENDFOR»</span>. 
			   <span class="«pre»title">«(entry.eContents.filter(TitleField).get(0) as TitleField).title»</span>. 
			   «IF (entry.eContents.filter(EditorField).size > 0)»In <span class="«pre»editor">«(entry.eContents.filter(EditorField).get(0) as EditorField).editor»</span>, editor,«ENDIF» 
			   <span class="«pre»booktitle"><i>«(entry.eContents.filter(BooktitleField).get(0) as BooktitleField).booktitle»</i></span>, 
			   «IF (entry.eContents.filter(VolumeField).size > 0)»
			   		volume <span class="«pre»volume">«(entry.eContents.filter(VolumeField).get(0) as VolumeField).volume»</span> 
		   		«ELSEIF (entry.eContents.filter(NumberField).size > 0)»
			   number <span class="«pre»number">«(entry.eContents.filter(NumberField).get(0) as NumberField).number»</span> 
		   		«ENDIF»
		   		«IF (entry.eContents.filter(SeriesField).size > 0)»of <span class="«pre»series">«(entry.eContents.filter(SeriesField).get(0) as SeriesField).series»</span>«ENDIF», 
		   		«IF (entry.eContents.filter(PagesField).size > 0)»page <span class="«pre»page">«(entry.eContents.filter(PagesField).get(0) as PagesField).pages»</span>, «ENDIF»
			   «IF (entry.eContents.filter(AddressField).size > 0)»<span class="«pre»address">«(entry.eContents.filter(AddressField).get(0) as AddressField).address»</span>, «ENDIF»
			   «IF (entry.eContents.filter(MonthField).size > 0)»<span class="«pre»month">«(entry.eContents.filter(MonthField).get(0) as MonthField).month»</span>«ENDIF» 
			   <span class="«pre»year">«(entry.eContents.filter(YearField).get(0) as YearField).year»</span>. 
			   «IF (entry.eContents.filter(OrganizationField).size > 0)»<span class="«pre»organization">«(entry.eContents.filter(OrganizationField).get(0) as OrganizationField).organization»</span>, «ENDIF»
			   «IF (entry.eContents.filter(PublisherField).size > 0)»<span class="«pre»publisher">«(entry.eContents.filter(PublisherField).get(0) as PublisherField).publisher»</span>. «ENDIF»
			   «IF (entry.eContents.filter(NoteField).size > 0)»<span class="«pre»note">«(entry.eContents.filter(NoteField).get(0) as NoteField).note»</span>.«ENDIF»
			   «IF (entry.eContents.filter(URLField).size > 0)»<br/>URL: <a href="«(entry.eContents.filter(URLField).get(0) as URLField).url»" class="«pre»url" style="color:black;"><i>
			   		«(entry.eContents.filter(URLField).get(0) as URLField).url»</i></a>.«ENDIF»
			</div>
		 </section>
		 <!-- end: entry for InProceeding -->
 	'''
 	
	public enum Sorting {
		AUTHOR,
		TITLE,
		YEAR,
		KEY,
		NONE
	}

	public enum Category {
		AUTHOR,
		YEAR,
		NONE
	}
	
	/*
	 * sort by first authors last name...
	 */
	public static class AuthorComparator implements Comparator<BibtexEntryTypes> {  
	    override int compare (BibtexEntryTypes e1, BibtexEntryTypes e2) {
	    	if(e1.eContents.filter(AuthorField).empty)
	    		return 1;
	    	if(e2.eContents.filter(AuthorField).empty)
	    		return -1;
	    		
	    	val authors1 = HTMLParserHelper.parseAuthors((e1.eContents.filter(AuthorField).get(0) as AuthorField).authors) 
	    	val authors2 = HTMLParserHelper.parseAuthors((e2.eContents.filter(AuthorField).get(0) as AuthorField).authors)  		
	    	
	        return authors1.get(0).lastname.compareTo(authors2.get(0).lastname)
	    }
	}
	def sortedEntrySet(Model model, OptionSet options) { //Sorting criteria, boolean asc, Category cat, boolean catasc) {
		var sortedList = model.bibtexEntries.clone;
		
		var Sorting criteria = Sorting.NONE
		var asc = true
		
		var Category cat = Category.NONE
		var catasc = true
		
		if(!options.eContents.filter(SortingOption).empty) {
			val sortby =(options.eAllContents.toIterable.filter(SortBy).get(0) as SortBy)
			switch sortby {
				case sortby.author:
					criteria = Sorting.AUTHOR
				case sortby.key:
					criteria = Sorting.KEY
				case sortby.year:
					criteria = Sorting.YEAR
				default:
					criteria = Sorting.NONE
			}
			asc = (options.eContents.filter(SortingOption).get(0) as SortingOption).asc
		}
		
		if(!options.eContents.filter(CategoryOption).empty) {
			val sortby =(options.eAllContents.toIterable.filter(CategorySortBy).get(0) as CategorySortBy)
			switch sortby {
				case sortby.author:
					cat = Category.AUTHOR
				case sortby.year:
					cat = Category.YEAR
				default:
					cat = Category.NONE
			}
			catasc = (options.eContents.filter(CategoryOption).get(0) as CategoryOption).asc
		}
		
		if(criteria == Sorting.NONE)
			return sortedList

		if (criteria == Sorting.AUTHOR)
			sortedList.sortInplace(new HTMLGeneratorGenerator.AuthorComparator()) //sortInplaceBy[(eContents.filter(AuthorField).get(0) as AuthorField).authors]
		else if (criteria == Sorting.TITLE)
			sortedList.sortInplaceBy[(eContents.filter(TitleField).get(0) as TitleField).title]
		else if (criteria == Sorting.YEAR)
			sortedList.sortInplaceBy[(eContents.filter(YearField).get(0) as YearField).year]
		else if (criteria == Sorting.KEY)
			sortedList.sortInplaceBy[key]

		if (!asc != !catasc) 
			sortedList = sortedList.reverse
			
		if(cat == Category.NONE)
			return sortedList;

		if (criteria != Sorting.YEAR && cat == Category.YEAR)
			sortedList.sortInplaceBy[(eContents.filter(YearField).get(0) as YearField).year]

		if (criteria != Sorting.AUTHOR && cat == Category.AUTHOR)
			sortedList.sortInplace(new HTMLGeneratorGenerator.AuthorComparator())

		if (!catasc)
			sortedList = sortedList.reverse

		return sortedList
	}

	override void doGenerate(Resource resource, IFileSystemAccess fsa) {
		val foldername = "/" +
			String.join("/", resource.getURI().segmentsList().subList(1, resource.getURI().segmentCount() - 1))

		val IFolder folder = ResourcesPlugin.getWorkspace().getRoot().getFolder(new Path(foldername));
		val String resLocation = folder.getRawLocation().toOSString();

		// Parse BibTeX-Model
		val ResourceSet resourceSet = new ResourceSetImpl();

		for (RunModule module : resource.getAllContents().toIterable().filter(typeof(RunModule))) {
			System.out.println(module.getModule().getName());
			var String bibtexEntries = "";
			var importAll = false;
			for (Import imp : module.getModule().eAllContents().toIterable().filter(typeof(Import))) {
				if(imp.isImportAll())
					importAll = true;
			}
			var List<String> files = new ArrayList<String>();
			if(!importAll) {
				for (Import imp : module.getModule().eAllContents().toIterable().filter(typeof(Import))) {
					files.add(imp.getImportBibtex())	
				}
							
			} else {
				for(String f : (new File(resLocation)).list )
					if(f.endsWith(".bib")) 
						files.addAll(f)
			}
			
			for (String file : files) {
				try {
					val byte[] data = Files.readAllBytes(Paths.get(resLocation, file));
					val String n = new String(
						data,
						Charset.defaultCharset()
					)
					bibtexEntries += n;
				} catch (FileNotFoundException e) {
					System.out.println("File not found: " + e.getMessage());
				} catch (Exception e) {
					System.out.println("Exception: " + e.getMessage());
				}						
			}

			try {
				val bibRes = resourceSet.createResource(org.eclipse.emf.common.util.URI.createURI("dummy:/inmemory.bib"))
				bibRes.load(new StringInputStream(bibtexEntries), resourceSet.getLoadOptions())
			
				if(bibRes.contents.empty) 
					throw new IOException("Please import *.bib-file(s) or check whether all imported files are empty.")
				
				// Bibtex-Model
				val Model bibtexModel = bibRes.contents.get(0) as Model
			    // Model-Validation
				val Diagnostic diagnostic = Diagnostician.INSTANCE.validate(bibtexModel);
				if(diagnostic.getSeverity() != Diagnostic.OK) { // oh boy, there are errors...
				   	var int errors = 0;
					var int warnings = 0;
					val StringBuilder builder = new StringBuilder();
				
					if(diagnostic.getSeverity() == Diagnostic.ERROR) {
						builder.append("Errors were found!").append('\n');
					}
					else {
						builder.append("Only warnings were found!").append('\n');
					}

					for(Diagnostic d : diagnostic.children) {
							builder.append('\n\n');
							if(d.getSeverity() == Diagnostic.ERROR) {
								builder.append("Error: ");
								errors++;
							}
							else {
								builder.append("Warning: ");
								warnings++;
							}
							builder.append(d.message + '\n');
							builder.append("(Source: " + d.source + ")");
					}
					builder.append('\n\n[').append(warnings).append(" warning(s), ").append(errors).append(" error(s)]");
					if(errors > 0) {
						builder.append(" Generation unsuccessful! Please check imported files, resolve all errors and try again.");
						throw new Exception(builder.toString());
					} else {
						System.out.println(builder.toString)
					}
				}
				
				//reset num-counter
				numCounter = 1

				//print output to file
				fsa.generateFile(module.getModule().getName() + ".html", // class name
				module.compile(bibtexModel))
				System.out.println(" Generation successful!");
			} 
			catch (IOException e) {
				System.out.println("IOException: " + e.getMessage());
			} 
			catch (Exception e) {
				System.out.println(e.getMessage()); //should rather be logged than printed to primary console...
			}

		}
	}
}
