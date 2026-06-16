page 50018 "Admin Assist Activities"
{
    Caption = 'Dashboard';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "Sales Cue";
    ShowFilter = false;
    Permissions = tabledata "ADT Requisition Header" = rim,
                      tabledata "ADT Requisition Line" = rm,
                      tabledata "Email Related Attachment" = rim;

    layout
    {
        area(Content)
        {
            cuegroup("Fuel &Requisitions")
            {
                Caption = 'Consumptions';
                field("Fuel Requisitions"; Rec."Fuel Requisitions")
                {
                    Caption = 'My Consumptions';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Fuel Requisitions";
                }
                field("Pending Fuel Requisitions"; Rec."Pending Fuel Requisitions")
                {
                    Caption = 'My Pending Consumptions';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Fuel Requisitions";
                }
                field("Approved Fuel Requisitions"; Rec."Approved Fuel Requisitions")
                {
                    Caption = 'My Approved Consumptions';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Fuel Requisitions";
                }
                field("Rejected Fuel Requisitions"; Rec."Rejected Fuel Requisitions")
                {
                    Caption = 'My Rejected Consumptions';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Fuel Requisitions";
                }

                field("All Fuel Requisitions"; Rec."All Fuel Requisitions")
                {
                    ApplicationArea = All;
                    Caption = 'All Consumptions';
                    DrillDownPageId = "All Fuel Requisitions";
                }

                field("All Pending Fuel Requisitions"; Rec."All Pending Fuel Requisitions")
                {
                    Caption = 'All Pending Consumptions';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Fuel Requisitions";
                }
                field("All Approved Fuel Requisitions"; Rec."All Approved Fuel Requisitions")
                {
                    Caption = 'All Approved Consumptions';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Fuel Requisitions";
                }
            }
            cuegroup("Spare Parts &Requisitions")
            {
                Caption = 'Spare Parts Requisitions';
                field("Spare Parts Requisitions"; Rec."MySpareParts Requisitions")
                {
                    Caption = 'My Spare Parts Requisitions';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Spare Part Requisition List";
                }
                field("Pending Spare Parts Requisitions"; Rec."MyPendingSparePrt Requisitions")
                {
                    Caption = 'My Pending Spare Parts Requisitions';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Spare Part Requisition List";
                }
                field("Approved Spare Parts Requisitions"; Rec."MyApprovedSparePt Requisitions")
                {
                    Caption = 'My Approved Spare Parts Requisitions';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Spare Part Requisition List";
                }
                field("Consumed Spare Parts Requisitions"; Rec."MyConsumedSparePt Requisitions")
                {
                    Caption = 'My Consumed Spare Parts Requisitions';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Spare Part Requisition List";
                }
                field("Purchased Spare Parts Requisitions"; Rec."MyPurchSparePt Requisitions")
                {
                    Caption = 'My Purchased Spare Parts Requisitions';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Spare Part Requisition List";
                }

                field("AllSpareParts Requisitions"; Rec."AllSpareParts Requisitions")
                {
                    Caption = 'All Spare Parts Requisitions';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "All Spare Part Requisitions";
                }
                field("AllPendingSparePt Requisitions"; Rec."AllPendingSparePt Requisitions")
                {
                    Caption = 'All Pending Spare Parts Requisitions';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "All Spare Part Requisitions";
                }
                field("AllApprovedSparPt Requisitions"; Rec."AllApprovedSparPt Requisitions")
                {
                    Caption = 'All Approved Spare Parts Requisitions';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "All Spare Part Requisitions";
                }
            }

            cuegroup(Drivers01)
            {
                Caption = 'Employees';
                field("All Employees"; Rec."All Employees")
                {
                    Caption = 'All Employees';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Employee List";
                }
                field(Drivers; Rec.Drivers)
                {
                    Caption = 'Registered Drivers';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Driver List";
                }
                field("Expired Licenses"; Rec."Expired Licenses")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Driver List";
                    StyleExpr = ColorRed;
                }
                field("Licenses Expiring Today"; Rec."Licenses Expiring Today")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Driver List";
                    StyleExpr = ColorRed;
                }
                field("LicensesExpiringWithin 3Months"; Rec."LicensesExpiringWithin 3Months")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Driver List";
                    StyleExpr = ColorYellow;
                }
                field("Available Drivers"; Rec."Active Drivers")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Available Drivers field.', Comment = '%';
                    DrillDownPageId = "Driver List";
                }
                field("Inactive Drivers"; Rec."Inactive Drivers")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inactive Drivers field.', Comment = '%';
                    StyleExpr = ColorYellow;
                    DrillDownPageId = "Driver List";
                }
                field("Terminated Drivers"; Rec."Terminated Drivers")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Terminated Drivers field.', Comment = '%';
                    StyleExpr = ColorRed;
                    DrillDownPageId = "Driver List";
                }
                field("Drivers On Leave"; Rec."Drivers On Leave")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Drivers On Leave field.', Comment = '%';
                    StyleExpr = ColorYellow;
                    DrillDownPageId = "Driver List";
                }
                field("Expired Medical Licenses"; Rec."Expired Medical Licenses")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expired Medical Licenses field.', Comment = '%';
                    StyleExpr = ColorRed;
                    DrillDownPageId = "Driver List";
                }
                field("Medical Licenses ExpiringToday"; Rec."Medical Licenses ExpiringToday")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Medical Licenses Expiring Today field.', Comment = '%';
                    StyleExpr = ColorRed;
                    DrillDownPageId = "Driver List";
                }
                field(MedLicenseExpiringWith3Months; Rec.MedLicenseExpiringWith3Months)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Medical Licenses Expiring Within 3 Months field.', Comment = '%';
                    StyleExpr = ColorYellow;
                    DrillDownPageId = "Driver List";
                }
                field("Expired Defensive Licenses"; Rec."Expired Defensive Licenses")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expired Defensive Licenses field.', Comment = '%';
                    StyleExpr = ColorRed;
                    DrillDownPageId = "Driver List";
                }
                field("Defensive LicensesExpireToday"; Rec."Defensive LicensesExpireToday")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Defensive Driving Expiring Today field.', Comment = '%';
                    StyleExpr = ColorRed;
                    DrillDownPageId = "Driver List";
                }
                field(DefLicenseExpiringWith3Months; Rec.DefLicenseExpiringWith3Months)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Defensive Driving Licenses Expiring Within 3 Months field.', Comment = '%';
                    StyleExpr = ColorYellow;
                    DrillDownPageId = "Driver List";
                }
            }

            cuegroup(MaintenanceRequests)
            {
                Caption = 'Maintenance Requests';
                field("Maintenance Requests"; Rec."Maintenance Requests")
                {
                    Caption = 'Open Maintenance Requests';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Maintenance Requests";
                }
                field("Pending Maintenance Requests"; Rec."Pending Maintenance Requests")
                {
                    Caption = 'My Pending Maintenance Requests';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Maintenance Requests";
                }
                field("Approved Maintenance Requests"; Rec."Approved Maintenance Requests")
                {
                    Caption = 'My Approved Maintenance Requests';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Maintenance Requests";
                }
                field("All Maintenance Requests"; Rec."All Maintenance Requests")
                {
                    Caption = 'All Maintenance Requests';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "All Maintenance Requests";
                }
                field("All Pending Maintenance Requests"; Rec.AllPendingMaintenanceRequests)
                {
                    Caption = 'All Pending Maintenance Requests';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "All Maintenance Requests";
                }
                field("All Approved Maintenance Requests"; Rec.AllApprovedMaintenanceRequests)
                {
                    Caption = 'All Approved Maintenance Requests';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "All Maintenance Requests";
                }
            }
            cuegroup(Jobs)
            {
                field("All Maintenance Jobs"; Rec."All Maintenance Jobs")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Maintenance Job Cards";
                    ToolTip = 'Specifies the value of the All Maintenance Jobs field.', Comment = '%';
                }
                field("New Maintenance Jobs"; Rec."New Maintenance Jobs")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Maintenance Job Cards";
                    ToolTip = 'Specifies the value of the New Maintenance Jobs field.', Comment = '%';
                }
                field("In Progress Maintenance Jobs"; Rec."In Progress Maintenance Jobs")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Maintenance Job Cards";
                    ToolTip = 'Specifies the value of the In Progress Maintenance Jobs field.', Comment = '%';
                }
                field("Closed Maintenance Jobs"; Rec."Closed Maintenance Jobs")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Maintenance Job Cards";
                    ToolTip = 'Specifies the value of the Closed Maintenance Jobs field.', Comment = '%';
                }
                field("Cancelled Maintenance Jobs"; Rec."Cancelled Maintenance Jobs")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Maintenance Job Cards";
                    ToolTip = 'Specifies the value of the Cancelled Maintenance Jobs field.', Comment = '%';
                }
            }

            cuegroup(OtherRequisitions)
            {
                Caption = 'Other Requisitions';

                field("All General Requisitions"; Rec."All General Requisitions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the All General Requisitions field.', Comment = '%';
                    DrillDownPageId = "All General Requisitions";
                }
                field("All HandOver Requisitions"; Rec."All HandOver Requisitions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the All Hand Over Requisitions field.', Comment = '%';
                    DrillDownPageId = "All Equipment HandOver Forms";
                }
            }
        }
    }

    var
        ColorRed: Text[50];
        ColorYellow: Text[50];

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;

        ColorRed := 'Unfavorable';
        ColorYellow := 'Ambiguous';

        Rec.SetRange("User ID Filter", UserId);
    end;

    trigger OnAfterGetRecord()
    begin
        CalculateCueFieldValues();
    end;

    local procedure CalculateCueFieldValues()
    begin
        // if FieldActive("Normal field") then
        //     "Normal field" := 2 + 1 //add some calculation here for normal fields;
    end;

}