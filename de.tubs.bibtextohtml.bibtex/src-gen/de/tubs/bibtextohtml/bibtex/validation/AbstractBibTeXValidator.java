/*
 * generated by Xtext
 */
package de.tubs.bibtextohtml.bibtex.validation;

import java.util.ArrayList;
import java.util.List;
import org.eclipse.emf.ecore.EPackage;

public class AbstractBibTeXValidator extends org.eclipse.xtext.validation.AbstractDeclarativeValidator {

	@Override
	protected List<EPackage> getEPackages() {
	    List<EPackage> result = new ArrayList<EPackage>();
	    result.add(de.tubs.bibtextohtml.bibtex.bibTeX.BibTeXPackage.eINSTANCE);
		return result;
	}
}
