page 50022 "Driver Card"
{
    Caption = 'Driver Card';
    PageType = Card;
    SourceTable = Employee;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Visible = NoFieldVisible;

                    trigger OnAssistEdit()
                    begin
                        Rec.AssistEdit();
                    end;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the employee''s middle name.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = BasicHR;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field("Full name"; Rec.FullName())
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s job title.';
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the employee''s gender.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifics if driver is blocked';
                }
                field("Phone No.2"; Rec."Phone No.")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Company Phone No.';
                    ToolTip = 'Specifies the employee''s telephone number.';
                    Visible = false;
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = BasicHR;
                    ExtendedDatatype = EMail;
                    ToolTip = 'Specifies the employee''s email address at the company.';
                    Visible = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = BasicHR;
                    Importance = Additional;
                    ToolTip = 'Specifies when this record was last modified.';
                    Visible = false;
                }
                field("Privacy Blocked"; Rec."Privacy Blocked")
                {
                    ApplicationArea = BasicHR;
                    Importance = Additional;
                    Visible = false;
                    ToolTip = 'Specifies whether to limit access to data for the data subject during daily operations. This is useful, for example, when protecting data from changes while it is under privacy review.';
                }
            }
            group("Address & Contact")
            {
                Caption = 'Address & Contact';
                group(Control13)
                {
                    ShowCaption = false;
                    field(Address; Rec.Address)
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the employee''s address.';
                    }
                    field("Address 2"; Rec."Address 2")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field(City; Rec.City)
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the city of the address.';
                    }
                    group(Control31)
                    {
                        ShowCaption = false;
                        Visible = IsCountyVisible;
                        field(County; Rec.County)
                        {
                            ApplicationArea = BasicHR;
                            ToolTip = 'Specifies the county of the employee.';
                        }
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the postal code.';
                        Visible = false;
                    }
                    field("Country/Region Code"; Rec."Country/Region Code")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the country/region of the address.';

                        trigger OnValidate()
                        begin
                            IsCountyVisible := FormatAddress.UseCounty(Rec."Country/Region Code");
                        end;
                    }
                    field(ShowMap; ShowMapLbl)
                    {
                        ApplicationArea = BasicHR;
                        Editable = false;
                        ShowCaption = false;
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                        ToolTip = 'Specifies the employee''s address on your preferred online map.';
                        Visible = false;

                        trigger OnDrillDown()
                        begin
                            CurrPage.Update(true);
                            Rec.DisplayMap();
                        end;
                    }
                }
                group(Control7)
                {
                    ShowCaption = false;
                    field("Mobile Phone No."; Rec."Mobile Phone No.")
                    {
                        ApplicationArea = BasicHR;
                        Caption = 'Private Phone No.';
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s private telephone number.';
                    }
                    field(Pager; Rec.Pager)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the employee''s pager number.';
                        Visible = false;
                    }
                    field(Extension; Rec.Extension)
                    {
                        ApplicationArea = BasicHR;
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s telephone extension.';
                        Visible = false;
                    }
                    field("Phone No."; Rec."Phone No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Direct Phone No.';
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s telephone number.';
                    }
                    field("E-Mail"; Rec."E-Mail")
                    {
                        ApplicationArea = BasicHR;
                        Caption = 'Private Email';
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s private email address.';
                    }
                    field("Alt. Address Code"; Rec."Alt. Address Code")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies a code for an alternate address.';
                        Visible = false;
                    }
                    field("Alt. Address Start Date"; Rec."Alt. Address Start Date")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the starting date when the alternate address is valid.';
                        Visible = false;
                    }
                    field("Alt. Address End Date"; Rec."Alt. Address End Date")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the last day when the alternate address is valid.';
                        Visible = false;
                    }
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date when the employee began to work for the company.';
                }
                field(Status; Rec."Driver Status")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employment Driver Status of the employee.';
                }
                field("Inactive Date"; Rec."Inactive Date")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the date when the employee became inactive, due to disability or maternity leave, for example.';
                }
                field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies a code for the cause of inactivity by the employee.';
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the date when the employee was terminated, due to retirement or dismissal, for example.';
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies a termination code for the employee who has been terminated.';
                }
                field("Emplymt. Contract Code"; Rec."Emplymt. Contract Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the employment contract code for the employee.';
                }
                field("Statistics Group Code"; Rec."Statistics Group Code")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                    ToolTip = 'Specifies a statistics group code to assign to the employee for statistical purposes.';
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = BasicHR;
                    Visible = false;
                    ToolTip = 'Specifies a resource number for the employee.';
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies a salesperson or purchaser code for the employee.';
                }
                field("Employee Type"; Rec."Employee Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(Personal)
            {
                Caption = 'Personal';
                field("Birth Date"; Rec."Birth Date")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s date of birth.';
                }
                field("NSSF"; Rec."Social Security No.")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the social security number of the employee.';
                }
                field(NIN; Rec.NIN)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the NIN field.', Comment = '%';
                }
                field(TIN; Rec.TIN)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TIN field.', Comment = '%';
                }
                field("Union Code"; Rec."Union Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the employee''s labor union membership code.';
                    Visible = false;
                }
                field("Union Membership No."; Rec."Union Membership No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the employee''s labor union membership number.';
                }
            }
            group("Licensing Details")
            {
                field("Years of Experience"; Rec."Years of Experience")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Years of Experience field.', Comment = '%';
                }
                field("Driving License ID"; Rec."Driving License ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driving License ID field.', Comment = '%';
                }
                field("Driving License Class"; Rec."Driving License Class")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driving License Class field.', Comment = '%';
                }
                field("License validity Start Date"; Rec."License validity Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the License validity Start Date field.', Comment = '%';
                }
                field("License Validity End date"; Rec."License Validity End date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the License Validity End date field.', Comment = '%';
                }
                field("License Expired"; Rec."License Expired")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the License Expired field.', Comment = '%';
                }
                field("Days to License expiry"; Rec."Days to License expiry")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Days to License expiry field.', Comment = '%';
                    // Editable = false;
                }
                field("DDT Certification(Provider)"; Rec."DDT Certification(Provider)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the DDT Certification(Provider) field.', Comment = '%';
                }
                field("DefensiveDrive ValidStartDate"; Rec."DefensiveDrive ValidStartDate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Defensive Driving validity Start Date field.', Comment = '%';
                }
                field("DefensiveDrive ValidEndDate"; Rec."DefensiveDrive ValidEndDate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Defensive Driving validity End Date field.', Comment = '%';
                }
                field("Defensive Driving Days"; Rec."Defensive Driving Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Defensive Driving Days field.', Comment = '%';
                }
                field("Medical Fitness (Provider)"; Rec."Medical Fitness (Provider)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Medical Fitness (Provider) field.', Comment = '%';
                }
                field("Fitness Validity Start Date"; Rec."Fitness Validity Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fitness Validity Start Date field.', Comment = '%';
                }
                field("Fitness Validity End Date"; Rec."Fitness Validity End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Fitness Validity End Date field.', Comment = '%';
                }
                field("Medical Fitness Days"; Rec."Medical Fitness Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Medical Fitness Days field.', Comment = '%';
                }
                field("Rewards/Sanctions"; Rec."Rewards/Sanctions")
                {
                    ApplicationArea = All;
                    MultiLine = false;
                    ToolTip = 'Specifies the value of the Rewards/Sanctions field.', Comment = '%';
                }
                field(Client; Rec.Client)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Client field.', Comment = '%';
                }
                field(Subcontractor; Rec.Subcontractor)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Subcontractor field.', Comment = '%';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Remarks field.', Comment = '%';
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                field("Employee Posting Group"; Rec."Employee Posting Group")
                {
                    ApplicationArea = BasicHR;
                    LookupPageID = "Employee Posting Groups";
                    Visible = false;
                    ToolTip = 'Specifies the employee''s type to link business transactions made for the employee with the appropriate account in the general ledger.';
                }
                field("Application Method"; Rec."Application Method")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies how to apply payments to entries for this employee.';
                }
                field("Bank Branch No."; Rec."Bank Branch No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies a number of the bank branch.';
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the number used by the bank for the bank account.';
                }
                field(IBAN; Rec.IBAN)
                {
                    ApplicationArea = BasicHR;
                    Visible = false;
                    ToolTip = 'Specifies the bank account''s international bank account number.';
                }
                field("SWIFT Code"; Rec."SWIFT Code")
                {
                    ApplicationArea = BasicHR;
                    Visible = false;
                    ToolTip = 'Specifies the SWIFT code (international bank identifier code) of the bank where the employee has the account.';
                }
            }
        }
        area(factboxes)
        {
            part(Control3; "Employee Picture")
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No." = field("No.");
            }
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::Employee),
                              "No." = field("No.");
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
            group("E&mployee")
            {
                Caption = 'E&mployee';
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
                action(Dimensions)
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = const(5200),
                                  "No." = field("No.");
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
                action("&Picture")
                {
                    ApplicationArea = BasicHR;
                    Caption = '&Picture';
                    Image = Picture;
                    RunObject = Page "Employee Picture";
                    RunPageLink = "No." = field("No.");
                    ToolTip = 'View or add a picture of the employee or, for example, the company''s logo.';
                }
                action(AlternativeAddresses)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Alternate Addresses';
                    Image = Addresses;
                    RunObject = Page "Alternative Address List";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Open the list of addresses that are registered for the employee.';
                }
                action("&Relatives")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Relatives';
                    Image = Relatives;
                    RunObject = Page "Employee Relatives";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Open the list of relatives that are registered for the employee.';
                }
                action("Mi&sc. Article Information")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Mi&sc. Article Information';
                    Image = Filed;
                    RunObject = Page "Misc. Article Information";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Open the list of miscellaneous articles that are registered for the employee.';
                }
                action("&Confidential Information")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Confidential Information';
                    Image = Lock;
                    RunObject = Page "Confidential Information";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Open the list of any confidential information that is registered for the employee.';
                }
                action("Q&ualifications")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Q&ualifications';
                    Image = Certificate;
                    RunObject = Page "Employee Qualifications";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'Open the list of qualifications that are registered for the employee.';
                }
                action("A&bsences")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'A&bsences';
                    Image = Absence;
                    RunObject = Page "Employee Absences";
                    RunPageLink = "Employee No." = field("No.");
                    ToolTip = 'View absence information for the employee.';
                }
                separator(Action23)
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
                    ToolTip = 'View categorized absence information for the employee.';
                }
                action("Misc. Articles &Overview")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Misc. Articles &Overview';
                    Image = FiledOverview;
                    RunObject = Page "Misc. Articles Overview";
                    ToolTip = 'View miscellaneous articles that are registered for the employee.';
                }
                action("Co&nfidential Info. Overview")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Co&nfidential Info. Overview';
                    Image = ConfidentialOverview;
                    RunObject = Page "Confidential Info. Overview";
                    ToolTip = 'View confidential information that is registered for the employee.';
                }
                separator(Action61)
                {
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
                action(Attachments)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal();
                    end;
                }
                action(PayEmployee)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Pay Employee';
                    Image = SuggestVendorPayments;
                    RunObject = Page "Employee Ledger Entries";
                    RunPageLink = "Employee No." = field("No."),
                                  "Remaining Amount" = filter(< 0),
                                  "Applies-to ID" = filter('');
                    ToolTip = 'View employee ledger entries for the record with remaining amount that have not been paid yet.';
                }
                action(Contact)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Contact';
                    Image = ContactPerson;
                    ToolTip = 'View or edit detailed information about the contact person at the employee.';

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
                    ToolTip = 'View a list of emails that you have sent to this employee.';

                    trigger OnAction()
                    var
                        Email: Codeunit Email;
                    begin
                        Email.OpenSentEmails(Database::Employee, Rec.SystemId);
                    end;
                }
            }
        }
        area(Processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(ApplyTemplate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Apply Template';
                    Ellipsis = true;
                    Image = ApplyTemplate;
                    ToolTip = 'Apply a template to update the entity with your standard settings for a certain type of entity.';

                    trigger OnAction()
                    var
                        EmployeeTemplMgt: Codeunit "Employee Templ. Mgt.";
                    begin
                        EmployeeTemplMgt.UpdateEmployeeFromTemplate(Rec);
                    end;
                }
                action(SaveAsTemplate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Save as Template';
                    Ellipsis = true;
                    Image = Save;
                    ToolTip = 'Save the employee card as a template that can be reused to create new employee cards. Employee templates contain preset information to help you fill fields on employee cards.';

                    trigger OnAction()
                    var
                        EmployeeTemplMgt: Codeunit "Employee Templ. Mgt.";
                    begin
                        EmployeeTemplMgt.SaveAsTemplate(Rec);
                    end;
                }
            }
            action(Email)
            {
                ApplicationArea = All;
                Caption = 'Send Email';
                Image = Email;
                ToolTip = 'Send an email to this employee.';

                trigger OnAction()
                var
                    TempEmailItem: Record "Email Item" temporary;
                    EmailScenario: Enum "Email Scenario";
                begin
                    TempEmailItem.AddSourceDocument(Database::Employee, Rec.SystemId);
                    if Rec."Company E-Mail" <> '' then
                        TempEmailItem."Send to" := Rec."Company E-Mail"
                    else
                        TempEmailItem."Send to" := Rec."E-Mail";
                    TempEmailItem.Send(false, EmailScenario::Default);
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                actionref(Email_Promoted; Email)
                {
                }
                actionref(PayEmployee_Promoted; PayEmployee)
                {
                }
            }
            group(Category_Category4)
            {
                Caption = 'Employee', Comment = 'Generated from the PromotedActionCategories property index 3.';

                actionref(Dimensions_Promoted; Dimensions)
                {
                }
                actionref("Co&mments_Promoted"; "Co&mments")
                {
                }
                actionref(Attachments_Promoted; Attachments)
                {
                }
                actionref(Contact_Promoted; Contact)
                {
                }
                actionref("Sent Emails_Promoted"; "Sent Emails")
                {
                }
                actionref("&Picture_Promoted"; "&Picture")
                {
                }
                actionref("&Confidential Information_Promoted"; "&Confidential Information")
                {
                }
                actionref("Q&ualifications_Promoted"; "Q&ualifications")
                {
                }
                actionref("A&bsences_Promoted"; "A&bsences")
                {
                }
                actionref("Ledger E&ntries_Promoted"; "Ledger E&ntries")
                {
                }
            }
            group(Category_Category5)
            {
                Caption = 'Navigate', Comment = 'Generated from the PromotedActionCategories property index 4.';

            }
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetNoFieldVisible();
        IsCountyVisible := FormatAddress.UseCounty(Rec."Country/Region Code");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        if GuiAllowed then
            if Rec."No." = '' then
                if DocumentNoVisibility.EmployeeNoSeriesIsDefault() then
                    NewMode := true;

        Rec."Employee Type" := 'DRIVER';
    end;

    trigger OnAfterGetCurrRecord()
    var
        Employee: Record Employee;
        EmployeeTemplMgt: Codeunit "Employee Templ. Mgt.";
    begin
        if not NewMode then
            exit;
        NewMode := false;

        if EmployeeTemplMgt.InsertEmployeeFromTemplate(Employee) then begin
            Rec.Copy(Employee);
            CurrPage.Update();
        end else
            if EmployeeTemplMgt.TemplatesAreNotEmpty() then
                CurrPage.Close();

        Rec."Employee Type" := 'DRIVER';
    end;

    var
        FormatAddress: Codeunit "Format Address";
        NoFieldVisible: Boolean;
        IsCountyVisible: Boolean;
        NewMode: Boolean;

        ShowMapLbl: Label 'Show on Map';

    local procedure SetNoFieldVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        NoFieldVisible := DocumentNoVisibility.EmployeeNoIsVisible();
    end;
}