import root;
import pad_layout;

string topDir = "../";

string files[], f_labels[];
pen f_pens[];
//files.push("simu/model1/1E5/mc_eff_data.root"); f_labels.push("model1"); f_pens.push(blue);
//files.push("simu/model2/1E5/mc_eff_data.root"); f_labels.push("model2"); f_pens.push(red);
//files.push("simu/model3/1E5/mc_eff_data.root"); f_labels.push("model3"); f_pens.push(heavygreen);
//files.push("simu/model4/1E5/mc_eff_data.root"); f_labels.push("model4"); f_pens.push(heavygreen);
files.push("simu/default/4E5/mc_eff_data.root"); f_labels.push("default"); f_pens.push(red);

string arms[];
//arms.push("0");
arms.push("1");

string n_protons[];
n_protons.push("1");
n_protons.push("2");
n_protons.push("3");
n_protons.push("4");

xTicksDef = LeftTicks(5., 1.);
yTicksDef = RightTicks(0.05, 0.01);

//----------------------------------------------------------------------------------------------------

NewPad(false);
for (int npi : n_protons.keys)
	NewPadLabel(n_protons[npi] + "proton(s) acc/exp");

for (int ai : arms.keys)
{
	NewRow();

	NewPadLabel("arm " + arms[ai]);

	for (int npi : n_protons.keys)
	{
		NewPad("$x_{\rm N}\ung{mm}$", "efficiency");

		for (int fi : files.keys)
			draw(RootGetObject(topDir + files[fi], "arm " + arms[ai] + "/exp prot " + n_protons[npi] + "/nsi = 5.0/p_eff2_vs_x_N"), "eb", f_pens[fi], f_labels[fi]);	

		limits((0, 0.7), (20, 1.05), Crop);

		xaxis(YEquals(1., false), dashed);
	}

	frame f_legend = BuildLegend();

	NewPad(false);
	attach(f_legend);
}

GShipout(vSkip=1mm);
