(* ::Package:: *)

(* ::Section:: *)
(*Header*)


(* File: TRQS.m *)
(* Description: Mathematica package for generating truly random quantum states using quantum random number generators. *)
(* Author: Jaroslaw Miszczak <miszczak@iitis.pl> *)
(* Version: 0.2.0 (07/05/2012) *)
(* License: GPLv3 *)


BeginPackage["TRQS`"];


Begin["`Private`"];

trqsHistory = {
	{"0.0.1", "10/01/2011", "Jarek", "Initial version."},
	{"0.0.2", "31/01/2011", "Jarek", "Some cleanups in functions."},
	{"0.0.3", "06/02/2011", "Jarek", "External functions for integer numbers."},
	{"0.0.4", "07/02/2011", "Jarek", "External functions for double numbers. Normal distribution."},
	{"0.0.5", "13/02/2011", "Jarek", "Some configuration related functions."},
	{"0.0.6", "14/02/2011", "Jarek", "Induced measures."},
	{"0.0.7", "15/02/2011", "Jarek", "Help messages updated."},
	{"0.0.9", "27/07/2011", "Jarek", "TrueRandomChoice function added."},
	{"0.1.0", "28/07/2011", "Jarek", "TrueRandomDynamicalMatrix function added."},
	{"0.1.1", "28/07/2011", "Jarek", "TrueRandomGraph function added."},
	{"0.1.5", "24/04/2012", "Jarek", "Preliminary support for QRNG service."},
	{"0.1.6", "27/04/2012", "Jarek", "Build system for the backend files improved."},
	{"0.1.7", "30/04/2012", "Jarek", "Documentation improvements and simple backend sanity check."},
	{"0.1.8", "02/05/2012", "Jarek", "Method for sharing login data for the QRNG backend"},
	{"0.1.9", "04/05/2012", "Jarek", "Connection checking improved for the QRNG backend"},
	{"0.2.0", "07/05/2012", "Jarek", "Support for lists of random numbers. Configuration functions for backends added."},
	{"0.2.1", "04/07/2012", "Jarek", "Minor chnages in the main Makefile. Documentation updated."}
};

trqsVersion = Last[trqsHistory][[1]];

trqsLastModification = Last[trqsHistory][[2]];

trqsNames = Names["TRQS`*"]

trqsHomeDir = DirectoryName[FindFile["TRQS.m"]];

trqsBackendName = "TRQS_BACKEND_NAME";

trqsBackendDir = "TRQS_" <> trqsBackendName;

trqsBackendBinPrefix = ToLowerCase[trqsBackendName];

trqsBinaries = ToString[trqsHomeDir <> trqsBackendDir];


End[];


Print["Package TRQS version ", TRQS`Private`trqsVersion, " (last modification: ", TRQS`Private`trqsLastModification, ")."];
Switch[ TRQS`Private`trqsBackendName,
"Quantis",
	Print["\!\(\*
StyleBox[\"INFO\",\nFontWeight->\"Bold\"]\)\!\(\*
StyleBox[\":\",\nFontWeight->\"Bold\"]\) Using " <> TRQS`Private`trqsBackendName <> " as a source of randomness."];
	Print["\!\(\*
StyleBox[\"Note\",\nFontWeight->\"Bold\"]\)\!\(\*
StyleBox[\":\",\nFontWeight->\"Bold\"]\) You should configure this backend with \!\(\*
StyleBox[\"QuantisSetDevice\",\nFontWeight->\"Bold\"]\) function by providing information about the type and id of the used Quantis device."];
	Print["\!\(\*
StyleBox[\"Note\",\nFontWeight->\"Bold\"]\)\!\(\*
StyleBox[\":\",\nFontWeight->\"Bold\"]\) By default the package will use a USB Quantis device with id set to 0."],
"QRNG",
	Print["\!\(\*
StyleBox[\"INFO\",\nFontWeight->\"Bold\"]\)\!\(\*
StyleBox[\":\",\nFontWeight->\"Bold\"]\)\!\(\*
StyleBox[\" \",\nFontWeight->\"Bold\"]\)Using " <> TRQS`Private`trqsBackendName <> " (https://qrng.physik.hu-berlin.de/) as a source of randomness."];
	Print["\!\(\*
StyleBox[\"Note\",\nFontWeight->\"Bold\"]\)\!\(\*
StyleBox[\":\",\nFontWeight->\"Bold\"]\) You have to use \!\(\*
StyleBox[\"QRNGSetCredentials\",\nFontWeight->\"Bold\"]\) function to provide login information required to use this backend."];
];


Unprotect@@TRQS`Private`trqsNames;
Clear@@TRQS`Private`trqsNames;


(* ::Section:: *)
(*Public interface*)


(* ::Subsection:: *)
(*Basic functions*)


TrueRandomInteger::usage = "TrueRandomInteger[{i_min,i_max}] returns a random integer in the range [i_min,i_max].";
TrueRandomInteger::usage = TrueRandomInteger::usage <> "\nTrueRandomInteger[{i_min, i_max}, dim] returns a list of random integers in the range [i_min, i_max] with dim elements.";
TrueRandomInteger::usage = TrueRandomInteger::usage <> "\nTrueRandomInteger[i] returns a random integer in the range [0,i].";
TrueRandomInteger::usage = TrueRandomInteger::usage <> "\nTrueRandomInteger[] returns 0 or 1.";


TrueRandomReal::usage = "TrueRandomReal[{x_min,x_max}] returns a random double in the range [x_min,x_max].";
TrueRandomReal::usage = TrueRandomReal::usage <> "\nTrueRandomReal[{x_min,x_max}, dim] returns a list of random double in the range [x_min,x_max] with dim elements.";
TrueRandomReal::usage = TrueRandomReal::usage <> "\nTrueRandomReal[i] returns a random double in the range [0,x].";
TrueRandomReal::usage = TrueRandomReal::usage <> "\nTrueRandomReal[] returns a random double in the range [0,1].";


TrueRandomRealNormal::usage = "TrueRandomRealNormal[m,s,dims] provides a sample of random numbers distributed according to the normal distribution N[m,s] in an array of dimensions given by dims.";


TrueGinibreMatrix::usage = "TrueGinibreMatrix[m,n] returns (m x n)-dimensional complex matrix with entries having real and complex parts distributed according to the normal distribution N[0,1].";


TrueRandomSimplex::usage = "TrueRandomSimplex[n] returns a uniformly distributed element of a standard n-simplex.";


TrueRandomChoice::usage = "TrueRandomChoice[{\!\(\*SubscriptBox[\(e\), \(1\)]\),\!\(\*SubscriptBox[\(e\), \(2\)]\),\[Ellipsis],\!\(\*SubscriptBox[\(e\), \(n\)]\)}] returns at random one of the \!\(\*SubscriptBox[\(e\), \(i\)]\).";


TrueRandomGraph::usage ="TrueRandomGraph[v,e] returns a pseudorandom graph with v vertices and e edges.";


(* ::Subsection::Closed:: *)
(*Pure states*)


TrueRandomKet::usage = "TrueRandomKet[d] returns a d-dimensional random pure state represented as a state vector.";


TrueRandomProductKet::usage = "TrueRandomProductKet[{d1,d2,...,dn}] returns a random pure state, which is an element of a space with the tensor product structure.";


TrueRandomUnitary::usage = "TrueRandomUnitary[d] returns d-dimensional random unitary matrix.";


TrueRandomLocalUnitary::usage = "TrueRandomLocalUnitary[{d1,d2,...,dn}] returns a random unitary matrix, which acts on the elements of a space with the tensor product structure.";


(* ::Subsection::Closed:: *)
(*Mixed states*)


TrueRandomStateHS::usage = "TrueRandomStateHS[d] returns a random state of dimension d, generated uniformly with respect to the Hilbert-Schmidt measure. This is equivalent to TrueRandomStateInduced[d,d].";


TrueRandomStateBures::usage = "TrueRandomStateBures[d] returns a random state of dimension d, generated uniformly with respect to the Bures measure.";


TrueRandomStateInduced::usage = "TrueRandomStateInduced[d,exK] returns a random state of dimension d, generated uniformly with respect to the induced measure with the external system of dimension exK.";


TrueRandomProductState::usage = "TrueRandomProductState[] returns a product random density matrix acting on the space with the tensor product structure and with each local component generated according to measure \[Mu], where \[Mu] can be set to \"HS\", \"Bures\" or some integer K describing an induced measure.";


(* ::Subsection::Closed:: *)
(*Channels*)


TrueRandomDynamicalMatrix::usage="TrueRandomDynamicalMatrix[n,k] returns a dynamical matrix acting on n-dimensional states with k eigenvalues equal to 0.";


(* ::Subsection:: *)
(*Configuration related functions*)


Switch[ TRQS`Private`trqsBackendName, 
	"Quantis",
		QuantisGetLibVersion::usage = "QuantisGetLibVersion[] returns a version number of an installed libQuantis library.";
		QuantisGetSerialNumber::usage = "QuantisGetSerialNumber[] returns a serial number of the Quantis device used as a backend.";
		QuantisSetDeviceId::usage = "QuantisSetDevice[id] sets the id number of the used Quantis device. This can be set to any positive integer.";
		QuantisSetDeviceType::usage = "QuantisSetDeviceType[type] sets the type of the used Quantis device. This can be set to USB or PCI.";
		QuantisSetDevice::usage = "QuantisSetDevice[type, id] sets the type and the id of the used Quantis device. See also: QuantisSetDeviceType and QuantisSetDeviceId.";
		QuantisGetDeviceId::usage = "QuantisGetDeviceId[] returns an id number of the used Quantis device.";
		QuantisGetDeviceType::usage = "QuantisGetDeviceType[] returns a type of the used Quantis device.";
		QuantisGetDevice::usage = "QuantisGetDevice[] reports the currently used Quantis device. See also: QuantisGetDeviceType and QuantisGetDeviceId.",
	"QRNG",
		QRNGGetLibVersion::usage = "QuantisGetLibVersion[] returns a version number of an installed libQRNG library.";
		QRNGSetCredentials::usage = "QRNGSetCredentials[user, pass] sets the username and the password used for connecting with the QRNG service (https://qrng.physik.hu-berlin.de/). This function must be used prior to using any functionality of the QRNG backend.";
		QRNGTestConnection::usage = "QRNGTestConnection[] tests if the QRNG service is available for use. In the case of a failure, it reports its cause.";
];


(* ::Section:: *)
(*Private definitions*)


Begin["`Private`"];


(* ::Subsection:: *)
(*Basic functions*)


Install[trqsBinaries <> "/" <> trqsBackendBinPrefix  <> "_random_integer"];
Install[trqsBinaries <> "/" <> trqsBackendBinPrefix  <> "_random_integer_1"];
Install[trqsBinaries <> "/" <> trqsBackendBinPrefix  <> "_random_integer_0"];
Install[trqsBinaries <> "/" <> trqsBackendBinPrefix  <> "_random_integer_n"];

Install[trqsBinaries <> "/" <> trqsBackendBinPrefix  <> "_random_double"];
Install[trqsBinaries <> "/" <> trqsBackendBinPrefix  <> "_random_double_1"];
Install[trqsBinaries <> "/" <> trqsBackendBinPrefix  <> "_random_double_0"];
Install[trqsBinaries <> "/" <> trqsBackendBinPrefix  <> "_random_double_n"];


TrueRandomRealNormal[m_,s_,dims_]:=FlattenAt[Fold[Partition[#1,#2]&,m+Sqrt[2]s InverseErf[-1+2 TrueRandomReal[{0,1},Times@@dims]],Reverse[dims]],1];

TrueGinibreMatrix[m_,n_]:=TrueRandomRealNormal[0,1,{m,n}] + I TrueRandomRealNormal[0,1,{m,n}];


TrueRandomSimplex[d_]:=Block[{r,r1,r2},
	r=Sort[TrueRandomReal[{0,1},d-1]];
	r1=Append[r,1];
    r2=Prepend[r,0];r1-r2
];


TrueRandomChoice[l_]:=l[[TrueRandomInteger[{1,Length[l]}]]];


TrueRandomGraph[{v_,e_},form_:"Graph"]:=Block[{maxE=1/2 (-v+v^2),edges={},newEdge,edgesLeft=e,noEdge,e1,e2},
	If[e>maxE,
		Message[TrueRandomGraph::argerr,e,v],
		While[edgesLeft>0,
			e1=RandomChoice[Range[v]];
			e2=RandomChoice[Delete[Range[v],e1]];
			newEdge=Sort[{e1,e2}];
			If[Length[Position[edges,newEdge]]==0,
				AppendTo[edges,newEdge];
				edgesLeft=edgesLeft-1;
			]
		];
		Switch[form,
			"Graph",Graph[Range[v],Map[UndirectedEdge[#[[1]],#[[2]]]&,edges]],
			"List", {Range[v],edges},
			_,Message[TrueRandomGraph::formerr,form]
		]
	]
];

TrueRandomGraph::argerr = "Invalid parameters `1` (vertices) and `2` (edges) in TrueRandomGraph function call.";
TrueRandomGraph::formerr = "Invalid output form. Please choose Graph or List (default)";


(* ::Subsection::Closed:: *)
(*Pure states*)


TrueRandomKet[n_]:=Block[{p,ph},
	p=Sqrt[TrueRandomSimplex[n]];
	ph=Exp[I TrueRandomReal[{0,2\[Pi]},n-1]];
	ph=Prepend[ph,1];
	p*ph
];


TrueRandomProductKet[l_]:=Fold[KroneckerProduct[#1,#2]&,{1},Map[TrueRandomKet[#]&,l]];


TrueRandomUnitary[dim_]:=Block[{Q,R},
	{Q,R}=QRDecomposition[TrueGinibreMatrix[dim,dim]];
	Q.DiagonalMatrix[Diagonal[R]/Abs[Diagonal[R]]]
];


TrueRandomLocalUnitary[l_]:=Fold[KroneckerProduct[#1,#2]&,{{1}},Map[TrueRandomUnitary[#]&,l]];


(* ::Subsection::Closed:: *)
(*Mixed states*)


TrueRandomStateHS[d_]:=Block[{A},
	A=TrueGinibreMatrix[d,d];
	A=(A.ConjugateTranspose[A]);
	A=Chop[A/Tr[A]]
];


TrueRandomStateBures[d_]:=Block[{A,U,X},
	A=TrueGinibreMatrix[d,d];
	U=TrueRandomUnitary[d];
	X=(IdentityMatrix[d]+U).A.A\[ConjugateTranspose].(IdentityMatrix[d]+U)\[ConjugateTranspose];
	Chop[X/Tr[X]]
];


TrueRandomStateInduced[d_,exK_]:=Block[{A},
	If[exK>=d,
		A=TrueGinibreMatrix[d,exK];
		A=(A.ConjugateTranspose[A]);
		A=Chop[A/Tr[A]],
		Message[TrueRandomStateInduced::argerr,exK]
	]
];
TrueRandomStateInduced::argerr = "The second argument should be larger or equal to the first one.";


TrueRandomProductState[l_,mu_:"HS"]:=Block[{},
	Switch[mu,
		"HS", Fold[KroneckerProduct[#1,#2]&,{{1}},Map[TrueRandomStateHS[#]&,l]],
		"Bures", Fold[KroneckerProduct[#1,#2]&,{{1}},Map[TrueRandomStateBures[#]&,l]],
		_, If[IntegerQ[dismu] && mu >=Max[l],
				Fold[KroneckerProduct[#1,#2]&,{{1}},Map[TrueRandomStateInduced[#,mu]&,l]],
				Message[TrueRandomProductState::argerr,dist]
			]
	]
];
RandomState::argerr = "The second argument should be \"HS\" or \"Bures\" or an integer K>2, mesure \"`1`\" not implemented yet.";


(* ::Subsection::Closed:: *)
(*Channels*)


TrueRandomDynamicalMatrix[n_,k_:0]:=Block[{mX=TrueGinibreMatrix[n^2,n^2-k],mY,di},
	mX=mX.mX\[ConjugateTranspose];
	mY=KroneckerProduct[
		DiagonalMatrix[Table[1,{n}]],
			MatrixPower[
				Table[Plus@@(Table[mX[[jj+n*ii ,1+n*ii;;(ii+1) n]],{ii,0,n-1}]),{jj,1,n}],
			-0.5
			]
		];
	mY.mX.mY
];


(* ::Subsection::Closed:: *)
(*Configuration related functions*)


Switch[ TRQS`Private`trqsBackendName, 
	"Quantis",
		Install[trqsBinaries<>"/quantis_get_lib_version"];
		Install[trqsBinaries<>"/quantis_get_serial_number"];
		TRQS`Private`QuantisDeviceId = 0; (* default configuration *)
		TRQS`Private`QuantisDeviceType = "USB"; (* default configuration *)
		QuantisSetDeviceId[n_Integer] := Block[{},
			TRQS`Private`QuantisDeviceId = n;
		];
		QuantisSetDeviceType[str_String] := Block[{},
			If[str=="PCI" || str == "USB", 
				TRQS`Private`QuantisDeviceType = str, 
			Message[QuantisSetDeviceType::argerr,dist]
			]
		];
		QuantisSetDeviceType::argerr = "The device type should be \"USB\" or \"PCI\". Device type \"`1`\" is not supported.";
		QuantisSetDevice[str_String, id_Integer] := Block[{}, QuantisSetDeviceType[str];QuantisSetDeviceId[id];Print["Using Quantis device: type=" <> str <> ", id=" <> ToString[id]]];
		QuantisGetDeviceId[] := TRQS`Private`QuantisDeviceId;
		QuantisGetDeviceType[] := TRQS`Private`QuantisDeviceType;
		QuantisGetDevice[] := Block[{type=QuantisGetDeviceType[], id = QuantisGetDeviceId[]}, Print["Using Quantis device: type=" <> ToString[type] <> ", id=" <> ToString[id]]],
	"QRNG", 
		Install[trqsBinaries<>"/qrng_get_lib_version"];
		Install[trqsBinaries<>"/qrng_test_connection"];
		QRNGSetCredentials[user_, pass_] := Block[{},
			TRQS`Private`QRNGUsername = user;
			TRQS`Private`QRNGPassword = pass; 
			Print["User name and password for using QRNG service set!"];
			Uninstall[trqsBinaries<>"/qrng_test_connection"];
			Install[trqsBinaries<>"/qrng_test_connection"];
		];
];


End[];


(* ::Subsection::Closed:: *)
(*Footer*)


Protect@@TRQS`Private`trqsNames;


EndPackage[];
