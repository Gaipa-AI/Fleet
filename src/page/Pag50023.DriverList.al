page 50023 "Driver List"
{
    ApplicationArea = BasicHR;
    Caption = 'Drivers';
    CardPageID = "Driver Card";
    Editable = false;
    PageType = List;
    SourceTable = Employee;
    SourceTableView = where("Employee Type" = filter('DRIVER'));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(FullName; Rec.FullName())
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Full Name';
                    ToolTip = 'Specifies the full name of the Driver.';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Private Phone No.';
                    ToolTip = 'Specifies the Driver''s private telephone number.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Private Email';
                    ToolTip = 'Specifies the Driver''s private email address.';
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ToolTip = 'Specifies the employee''s date of birth.';
                }
                field("Years of Experience"; Rec."Years of Experience")
                {
                    ToolTip = 'Specifies the value of the Years of Experience field.', Comment = '%';
                }
                field("Driving License ID"; Rec."Driving License ID")
                {
                    ToolTip = 'Specifies the value of the Driving License ID field.', Comment = '%';
                }
                field("Driving License Class"; Rec."Driving License Class")
                {
                    ToolTip = 'Specifies the value of the Driving License Class field.', Comment = '%';
                }
                field("Driving License Validity"; (Format(Rec."License validity Start Date") + '-' + Format(Rec."License Validity End date")))
                {
                    ApplicationArea = All;
                }
                field("DDT Certification(Provider)"; Rec."DDT Certification(Provider)")
                {
                    ApplicationArea = All;
                }
                field("Defensive Driving Validity"; Format(Rec."DefensiveDrive ValidStartDate") + '-' + Format(Rec."DefensiveDrive ValidEndDate"))
                {
                    ApplicationArea = All;
                }
                field("Medical Fitness (Provider)"; Rec."Medical Fitness (Provider)")
                {
                    ApplicationArea = All;
                }
                field("Medical Fitness Validity"; Format(Rec."Fitness Validity Start Date") + '-' + Format(Rec."Fitness Validity End Date"))
                {
                    ApplicationArea = All;
                }
                field("Rewards/Sanctions"; Rec."Rewards/Sanctions")
                {
                    ApplicationArea = All;
                }
                field(Client; Rec.Client)
                {
                    ApplicationArea = All;
                }
                field(Subcontractor; Rec.Subcontractor)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::Employee), "No." = field("No.");
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Driver")
            {
                Caption = 'Driver';
                Image = Employee;
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = const(Employee),
                                  "No." = field("No.");
                    ToolTip = 'View or add comments for the record.';
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    action("Dimensions-Single")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Dimensions-Single';
                        Image = Dimensions;
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = const(5200),
                                      "No." = field("No.");
                        ShortCutKey = 'Alt+D';
                        ToolTip = 'View or edit the single set of dimensions that are set up for the selected record.';
                    }
                    action("Dimensions-&Multiple")
                    {
                        AccessByPermission = TableData Dimension = R;
                        ApplicationArea = Dimensions;
                        Caption = 'Dimensions-&Multiple';
                        Image = DimensionSets;
                        ToolTip = 'View or edit dimensions for a group of records. You can assign dimension codes to transactions to distribute costs and analyze historical information.';

                        trigger OnAction()
                        var
                            Driver: Record Employee;
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";
                        begin
                            CurrPage.SetSelectionFilter(Driver);
                            DefaultDimMultiple.SetMultiRecord(Driver, Rec.FieldNo("No."));
                            DefaultDimMultiple.RunModal();
                        end;
                    }
                }
                action("&Picture")
                {
                    ApplicationArea = BasicHR;
                    Caption = '&Picture';
                    Image = Picture;
                    RunObject = Page "Employee Picture";
                    RunPageLink = "No." = field("No.");
                    ToolTip = 'View or add a picture of the Driver or, for example, the company''s logo.';
                }
                action(AlternativeAddresses)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Alternate Addresses';
                    Image = Addresses;
                    RunObject = Page "Alternative Address List";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Open the list of addresses that are registered for the Driver.';
                }
                action("&Relatives")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Relatives';
                    Image = Relatives;
                    RunObject = Page "Employee Relatives";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Open the list of relatives that are registered for the Driver.';
                }
                action("Mi&sc. Article Information")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Mi&sc. Article Information';
                    Image = Filed;
                    RunObject = Page "Misc. Article Information";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Open the list of miscellaneous articles that are registered for the Driver.';
                }
                action("Co&nfidential Information")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Co&nfidential Information';
                    Image = Lock;
                    RunObject = Page "Confidential Information";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Open the list of any confidential information that is registered for the Driver.';
                }
                action("Q&ualifications")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Q&ualifications';
                    Image = Certificate;
                    RunObject = Page "Employee Qualifications";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Open the list of qualifications that are registered for the Driver.';
                }
                action("A&bsences")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'A&bsences';
                    Image = Absence;
                    RunObject = Page "Employee Absences";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'View absence information for the Driver.';
                }
                separator(Action51)
                {
                }
                action("Absences by Ca&tegories")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Absences by Ca&tegories';
                    Image = AbsenceCategory;
                    RunObject = Page "Empl. Absences by Categories";
                    RunPageLink = "No." = field("No."),
                                  "Employee No. Filter" = field("No.");
                    ToolTip = 'View categorized absence information for the Driver.';
                }
                action("Misc. Articles &Overview")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Misc. Articles &Overview';
                    Image = FiledOverview;
                    RunObject = Page "Misc. Articles Overview";
                    ToolTip = 'View miscellaneous articles that are registered for the Driver.';
                }
                action("Con&fidential Info. Overview")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Con&fidential Info. Overview';
                    Image = ConfidentialOverview;
                    RunObject = Page "Confidential Info. Overview";
                    ToolTip = 'View confidential information that is registered for the Driver.';
                }
                action(Contact)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Contact';
                    Image = ContactPerson;
                    ToolTip = 'View or edit detailed information about the contact person at the Driver.';

                    trigger OnAction()
                    var
                        ContBusRel: Record "Contact Business Relation";
                        Contact: Record Contact;
                    begin
                        if ContBusRel.FindByRelation(ContBusRel."Link to Table"::Employee, Rec."No.") then begin
                            Contact.Get(ContBusRel."Contact No.");
                            Page.Run(Page::"Contact Card", Contact);
                        end;
                    end;
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                action("Sent Emails")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sent Emails';
                    Image = ShowList;
                    ToolTip = 'View a list of emails that you have sent to this Driver.';

                    trigger OnAction()
                    var
                        Email: Codeunit Email;
                    begin
                        Email.OpenSentEmails(Database::Employee, Rec.SystemId);
                    end;
                }
            }
        }
        area(processing)
        {
            action("Absence Registration")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Absence Registration';
                Image = Absence;
                RunObject = Page "Absence Registration";
                ToolTip = 'Register absence for the Driver.';
            }
            action("Ledger E&ntries")
            {
                ApplicationArea = BasicHR;
                Caption = 'Ledger E&ntries';
                Image = VendorLedger;
                RunObject = Page "Employee Ledger Entries";
                RunPageLink = "Employee No." = field("No.");
                RunPageView = sorting("Employee No.")
                              order(Descending);
                ShortCutKey = 'Ctrl+F7';
                ToolTip = 'View the history of transactions that have been posted for the selected record.';
            }
            action(PayDriver)
            {
                ApplicationArea = BasicHR;
                Caption = 'Pay Driver';
                Image = SuggestVendorPayments;
                RunObject = Page "Employee Ledger Entries";
                RunPageLink = "Employee No." = field("No."),
                              "Remaining Amount" = filter(< 0),
                              "Applies-to ID" = filter('');
                ToolTip = 'View Driver ledger entries for the selected record with remaining amount that have not been paid yet.';
            }
            action(ApplyTemplate)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Apply Template';
                Ellipsis = true;
                Image = ApplyTemplate;
                ToolTip = 'Apply a template to update one or more entities with your standard settings for a certain type of entity.';

                trigger OnAction()
                var
                    Driver: Record Employee;
                    DriverTemplMgt: Codeunit "Employee Templ. Mgt.";
                begin
                    CurrPage.SetSelectionFilter(Driver);
                    DriverTemplMgt.UpdateEmployeesFromTemplate(Driver);
                end;
            }
            action(Email)
            {
                ApplicationArea = All;
                Caption = 'Send Email';
                Image = Email;
                ToolTip = 'Send an email to this Driver.';
                Enabled = CanSendEmail;

                trigger OnAction()
                var
                    TempEmailItem: Record "Email Item" temporary;
                    EmailScenario: Enum "Email Scenario";
                begin
                    TempEmailItem.AddSourceDocument(Database::Employee, Rec.SystemId);
                    if Rec."Company E-Mail" <> '' then
                        TempEmailitem."Send to" := Rec."Company E-Mail"
                    else
                        TempEmailitem."Send to" := Rec."E-Mail";
                    TempEmailItem.Send(false, EmailScenario::Default);
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(Email_Promoted; Email)
                {
                }
                actionref(ApplyTemplate_Promoted; ApplyTemplate)
                {
                }
                actionref("Absence Registration_Promoted"; "Absence Registration")
                {
                }
                actionref(PayDriver_Promoted; PayDriver)
                {
                }
                actionref("Ledger E&ntries_Promoted"; "Ledger E&ntries")
                {
                }
            }
            group(Category_Driver)
            {
                Caption = 'Driver';

                group(Category_Dimensions)
                {
                    Caption = 'Dimensions';
                    ShowAs = SplitButton;

                    actionref("Dimensions-&Multiple_Promoted"; "Dimensions-&Multiple")
                    {
                    }
                    actionref("Dimensions-Single_Promoted"; "Dimensions-Single")
                    {
                    }
                }
                actionref("Co&mments_Promoted"; "Co&mments")
                {
                }
                actionref(Contact_Promoted; Contact)
                {
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        Driver: Record Employee;
    begin
        CurrPage.SetSelectionFilter(Driver);
        CanSendEmail := Driver.Count() = 1;
    end;

    var
        CanSendEmail: Boolean;

}
