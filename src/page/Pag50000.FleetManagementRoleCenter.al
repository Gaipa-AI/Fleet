page 50000 "Fleet Management Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Control76; "Headline RC Fleet Management")
            {
                ApplicationArea = Basic, Suite;
            }
            part("Admin Assist Activities"; "Admin Assist Activities")
            {
                ApplicationArea = Suite;
            }
            part("Equipment Activities"; "Equipment Activities")
            {
                ApplicationArea = Suite;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
        }
    }

    actions
    {
        area(Creation)
        {
            
            action("EquipmentTypesCreation")
            {
                Caption = 'Equipment Types';
                Image = List;
                RunObject = Page "Equipment Types";
            }
            

        }
        
        
        area(Reporting)
        {
            group(Report)
            {
                Caption = 'Reports';

                action("Report1")
                {
                    ApplicationArea= All;
                    Caption = 'Stock At Hand Report';
                    Image = Report;
                    RunObject = Report "Stock At Hand Report";

                }
                action("Report2")
                {
                    ApplicationArea= All;
                    Caption = 'Stock Movement Report';
                    Image = Report;
                    RunObject = Report "Stock Movement Report";

                }
                action("Report3")
                {
                    ApplicationArea= All;
                    Caption = 'PMF Report';
                    Image = Report;
                    RunObject = Report "Performance Monitoring Report";

                }
                action("Report4")
                {
                    ApplicationArea= All;
                    Caption = 'Routine Service Tracker';
                    Image = Report;
                    RunObject = Report "Routine Maintenance";

                }
                action("Report5")
                {
                    ApplicationArea= All;
                    Caption = 'Trips Report';
                    Image = Report;
                    RunObject = Report "Trips Report";

                }
                action("Report6")
                {
                    ApplicationArea= All;
                    Caption = 'Fuel Report';
                    Image = Report;
                    RunObject = Report "Fuel Consumption";

                }
                // action("Report7")
                // {
                //     ApplicationArea= All;
                //     Caption = 'Hire Report';
                //     Image = Report;
                //     RunObject = Report "Equipment Hire Jobs Report";

                // }
                action("Report8")
                {
                    ApplicationArea= All;
                    Caption = 'Repair Cost';
                    Image = Report;
                    RunObject = Report "Repair Cost Report";

                }
                action("Report9")
                {
                    ApplicationArea= All;
                    Caption = 'Hiring Report';
                    Image = Report;
                    RunObject = Report "Hire Report";

                }
                action("Report10")
                {
                    ApplicationArea= All;
                    Caption = 'Hiring Sales';
                    Image = Report;
                    RunObject = Report "HireSales";

                }

            }

        }
        area(Sections)
        {

            group("Equipment Handover Forms")
            {
                action("OpenEquipment HandOverForms")
                {
                    Caption = 'Open';
                    Image = List;
                    RunObject = Page "All Equipment HandOver Forms";
                    RunPageView = where(Status = const(Open));

                }
                action("PendingEquipment HandOverForms")
                {
                    Caption = 'Pending';
                    Image = List;
                    RunObject = Page "All Equipment HandOver Forms";
                    RunPageView = where(Status = const("Pending Approval"));

                }
                action("ApprovedEquipment HandOverForms")
                {
                    Caption = 'Approved';
                    Image = List;
                    RunObject = Page "All Equipment HandOver Forms";
                    RunPageView = where(Status = const("Released"), "Driver Assigned" = const(false));

                }
                action("RejectedEquipment HandOverForms")
                {
                    Caption = 'Rejected';
                    Image = List;
                    RunObject = Page "All Equipment HandOver Forms";
                    RunPageView = where(Status = const("Rejected"));

                }
                action("ReassignedEquipment HandOverForms")
                {
                    Caption = 'Reassigned';
                    Image = List;
                    RunObject = Page "All Equipment HandOver Forms";
                    RunPageView = where("Driver Assigned" = const(true));

                }
                
            }
            group("Journey Management Plans")
            {
                action("OpenJourneyManagementPlans")
                {
                    Caption = 'Open';
                    Image = List;
                    RunObject = Page "Journey Management Plans";
                    RunPageView = where(Status = const(Open));

                }
                action("PendingJourneyManagementPlans")
                {
                    Caption = 'Pending';
                    Image = List;
                    RunObject = Page "Journey Management Plans";
                    RunPageView = where(Status = const("Pending Approval"));

                }
                action("ApprovedJourneyManagementPlans")
                {
                    Caption = 'Approved';
                    Image = List;
                    RunObject = Page "Journey Management Plans";
                    RunPageView = where(Status = const("Released"),"Journey Started" = const(false));
                     
                }
                action("RejectedJourneyManagementPlans")
                {
                    Caption = 'Rejected';
                    Image = List;
                    RunObject = Page "Journey Management Plans";
                    RunPageView = where(Status = const("Rejected"),"Journey Started" = const(false));
                     
                }
                group(StartedJMPs)
    
                {
                    action("StartedJourneyManagementPlans")
                    {
                        Caption = 'Started';
                        Image = List;
                        RunObject = Page "Journey Management Plans";
                        RunPageView = where("Journey Started" = const(true),"Journey Ended" = const(false));
                    }
                    action("CompletedJourneyManagementPlans")
                    {
                        Caption = 'Completed';
                        Image = List;
                        RunObject = Page "Journey Management Plans";
                        RunPageView = where("Journey Ended" = const(true));

                    }
                }

            }
            group("Checklist")
            {
                Caption = 'Checklists';

                action("GoodInspections")
                {
                    Caption = 'Good Condition';
                    Image = List;
                    RunObject = Page "Inspection Checklists";
                    RunPageView = where("State" = const("Good Condition"));
                }
                action("FaultyInspections")
                {
                    Caption = 'Faulty';
                    Image = List;
                    RunObject = Page "Inspection Checklists";
                    RunPageView = where("State" = const("Faulty"));
                }
                action("FixedInspections")
                {
                    Caption = 'Fixed';
                    Image = List;
                    RunObject = Page "Inspection Checklists";
                    RunPageView = where("State" = const("Fixed"));
                }

            }
            group("Asset Management")
            {
                action("EquipmentListSection")
                {
                    Caption = 'Equipments';
                    Image = List;
                    RunObject = Page "Fixed Asset List";
                }
                action("EquipmentTypesSection")
                {
                    Caption = 'Equipment Types';
                    Image = List;
                    RunObject = Page "Equipment Types";
                }
                action("EquipmentHandOverForms")
                {
                    Caption = 'Equipment Handover Forms';
                    Image = List;
                    RunObject = Page "All Equipment HandOver Forms";
                }
            }
            group("Driver Management")
            {
                action("DriverListSection")
                {
                    Caption = 'Drivers';
                    Image = List;
                    RunObject = Page "Driver List";
                    RunPageView = where("Employee Type" = filter('DRIVER'));
                }
                action("EquipmentHandOverFormsDR")
                {
                    Caption = 'Equipment Handover Forms';
                    Image = List;
                    RunObject = Page "All Equipment HandOver Forms";
                }
                action(PerformanceMonitoring)
                {
                    Caption = 'Performance Monitoring Forms';
                    Image = List;
                    RunObject = page "Performance Monitoring Forms";
                }
                group("Incident Forms")
                {
                    //Caption = 'Incidents';
                action(OpenIncidentForms)
                {
                    Caption = 'Open Incidents';
                    Image = List;
                    RunObject = page "Incident Forms";
                    RunPageView = where("Status" = const("Open"));
                }
                action(PendingIncidentForms)
                {
                    Caption = 'Pending Incidents';
                    Image = List;
                    RunObject = page "Incident Forms";
                    RunPageView = where("Status" = const("Pending Approval"));
                }
                action(VerifiedIncidentForms)
                {
                    Caption = 'Verified Incidents';
                    Image = List;
                    RunObject = page "Incident Forms";
                    RunPageView = where("Status" = const("Released"), "Incident Posted" = const(false));
                }
                action(UnverifiedIncidentForms)
                {
                    Caption = 'Unverified Incidents';
                    Image = List;
                    RunObject = page "Incident Forms";
                    RunPageView = where("Status" = const("Rejected"));
                }
                action(PostedIncidentForms)
                {
                    Caption = 'Posted Incidents';
                    Image = List;
                    RunObject = page "Incident Forms";
                    RunPageView = where("Incident Posted" = const(true));
                }
                action(ComplaintIncidentForms)
                {
                    Caption = 'Posted Complaints';
                    Image = List;
                    RunObject = page "Incident Forms";
                    RunPageView = where("Complaint Posted" = const(true));
                }
                
                
                }
                
            }
            group(HiringAndCustomerManagement)
            {
                Caption = 'Hiring and Customer Management';
                group("Equipment Hire Requests")
                {
                    Caption = 'Vehicle|Equipment Hire Requests';
                    Visible = false;
                    group(InternalRequests)
                    {
                        Caption = 'Internal Hire Requests';
                        action("Internal Hire Requests")
                        {
                            ApplicationArea = All;
                            Image = Approvals;
                            Caption = 'All Internal Hire Requests';
                            RunObject = page "Internal Hire Requests";
                        }
                        action("Open Internal Hire Requests")
                        {
                            ApplicationArea = All;
                            Image = Approvals;
                            Caption = 'Open Internal Hire Requests';
                            RunObject = page "Internal Hire Requests";
                            RunPageView = where(Converted = const(false));
                        }
                        action("Started Internal Requests")
                        {
                            ApplicationArea = All;
                            Image = Approvals;
                            Caption = 'Started';
                            RunObject = page "Internal Hire Requests";
                            RunPageView = where("Journey Started" = const(true), "Journey Ended"= const(false));
                        }
                        action("Ended Internal Requests")
                        {
                            ApplicationArea = All;
                            Image = Approvals;
                            Caption = 'Ended';
                            RunObject = page "Internal Hire Requests";
                            RunPageView = where("Journey Started" = const(true), "Journey Ended"= const(true));
                        }
                        action("Converted Internal Requests")
                        {
                            ApplicationArea = All;
                            Image = Approvals;
                            Caption = 'Converted';
                            RunObject = page "Internal Hire Requests";
                            RunPageView = where("Converted" = const(true));
                        }
                    }
                    group(ExternalRequests)
                    {
                        Caption = 'External Hire Requests';
                        
                        action("External Hire Requests")
                        {
                            ApplicationArea = All;
                            Image = Approvals;
                            Caption = 'External Hire Requests';
                            RunObject = page "External Hire Requests";
                        }
                        action("Open External Hire Requests")
                        {
                            ApplicationArea = All;
                            Image = Approvals;
                            Caption = 'New External Hire Requests';
                            RunObject = page "External Hire Requests";
                            RunPageView = where(Status = const(Open));
                        }
                        action("Pending External Hire Requests")
                        {
                            ApplicationArea = All;
                            Image = Approvals;
                            Caption = 'External Hire Requests';
                            RunObject = page "External Hire Requests";
                            RunPageView = where(Status = const("Pending Approval"));
                        }
                        action("Approved External Hire Requests")
                        {
                            ApplicationArea = All;
                            Image = Approvals;
                            Caption = 'Approved External Hire Requests';
                            RunObject = page "External Hire Requests";
                            RunPageView = where(Status = const(Released), Converted = const(false));
                        }
                        action("Sold External Hire Requests")
                        {
                            ApplicationArea = All;
                            Image = Approvals;
                            Caption = 'Sold External Hire Requests';
                            RunObject = page "External Hire Requests";
                            RunPageView = where(Status = const(Released), Converted = const(true));
                        }


                    }
                }
                group(Sales)
                {
                    Caption = 'Hire Sales';
                    
                    action(salesOrders)
                    {
                        ApplicationArea = All;
                        Image = Approvals;
                        Caption = 'Open Sales Orders';
                        RunObject = page "Sales Order List";
                        RunPageView = where(Status = const("Open"));
                        
                    }
                    action(PendingsalesOrders)
                    {
                        ApplicationArea = All;
                        Image = Approvals;
                        Caption = 'Sales Orders';
                        RunObject = page "Sales Order List";
                        RunPageView = where(Status = const("Pending Approval"));

                    }
                    action(ApprovedsalesOrders)
                    {
                        ApplicationArea = All;
                        Image = Approvals;
                        Caption = 'Approved Sales Orders';
                        RunObject = page "Sales Order List";
                         RunPageView = where(Status = const(Released));

                    }
                    action(salesInvoices)
                    {
                        ApplicationArea = All;
                        Image = Approvals;
                        Caption = 'Sales Invoices';
                        RunObject = page "Sales Invoice List";
                    }
                    action(salesCreditMemos)
                    {
                        ApplicationArea = All;
                        Image = Approvals;
                        Caption = 'Sales Credit Memos';
                        RunObject = page "Sales Credit Memos";
                    }
                }

                group(PostedDocuments)
                {
                    Caption = 'Posted Documents';
                    action(PostedSalesInvoices)
                    {
                        ApplicationArea = All;
                        Image = Approvals;
                        Caption = 'Posted Sales Invoices';
                        RunObject = page "Posted Sales Invoices";
                    }
                    action(PostedSalesCreditMemos)
                    {
                        ApplicationArea = All;
                        Image = Approvals;
                        Caption = 'Posted Sales Credit Memos';
                        RunObject = page "Posted Sales Credit Memos";
                    }
                }
                group(Customers)
                {
                    action(CustomerList)
                    {
                        ApplicationArea = All;
                        Image = Approvals;
                        Caption = 'Customers';
                        RunObject = page "Customer List";
                    }
                }
            }
            group("Requisition Management")
            {
                group("Consumptions")
                {
                    group(Lists4)
                    {
                        Caption = 'Lists';
                        action("Fuel Requisition List")
                        {
                            ApplicationArea = All;
                            Caption = 'Open Consumptions';
                            RunObject = page "Fuel Requisitions";
                            RunPageView = where(Status = filter(Open), Archived = filter(false));
                            Image = List;
                        }
                        action("Pending Approvals Fuel Requisition")
                        {
                            ApplicationArea = All;
                            Caption = 'Pending Consumptions';
                            RunObject = page "Fuel Requisitions";
                            RunPageView = where(Status = filter("Pending Approval" | "Pending Prepayment"), Archived = filter(false));
                            Image = List;
                        }
                        action("Approved Fuel Requisitions")
                        {
                            ApplicationArea = All;
                            Image = Approvals;
                            Caption = 'Approved Consumptions';
                            RunObject = page "Fuel Requisitions";
                            RunPageView = where(Status = filter(Released), Archived = filter(false));
                        }
                        action("Rejected Fuel Requisitions")
                        {
                            ApplicationArea = All;
                            Image = Approvals;
                            Caption = 'Rejected Consumptions';
                            RunObject = page "Fuel Requisitions";
                            RunPageView = where(Status = filter(Rejected), Archived = filter(false));
                        }
                        action("All Fuel Requisitions")
                        {
                            ApplicationArea = All;
                            Image = Approvals;
                            Caption = 'All Fuel Consumptions';
                            RunObject = page "All Fuel Requisitions";
                            RunPageView = where(Archived = filter(false));
                        }
                    }
                    group(JournalsFuel)
                    {
                        Caption = 'Journals';
                        action(ItemJournals)
                        {
                            ApplicationArea = All;
                            Caption = 'Item Journals';
                            Image = Journals;
                            RunObject = page "Item Journal Batches";
                            RunPageView = where("Journal Template Name" = const('ITEM'));
                        }
                    }
                    group(Archives120)
                    {
                        Caption = 'Archives';
                        action("Fuel Requisition List Archives")
                        {
                            ApplicationArea = All;
                            Caption = 'Fuel Consumptions List Archives';
                            Image = Archive;
                            RunObject = page "All Fuel Requisitions";
                            RunPageView = where(Status = filter(Released), Archived = filter(true));
                        }
                    }

                }
                group("Spare Parts Requisitions")
                {
                    group(Lists3)
                    {
                        Caption = 'Lists';
                        action("Spare Parts Requisition List")
                        {
                            ApplicationArea = All;
                            Caption = 'Spare Parts Requisition List';
                            RunObject = page "Spare Part Requisition List";
                            RunPageView = where(Status = filter(Open), Archived = filter(false));
                            Image = List;
                        }
                        action("Pending Approvals Spare Parts Requisition")
                        {
                            ApplicationArea = All;
                            Caption = 'Pending Approvals Spare Parts Requisition';
                            RunObject = page "Spare Part Requisition List";
                            RunPageView = where(Status = filter("Pending Approval" | "Pending Prepayment"), Archived = filter(false));
                            Image = List;
                        }
                        action("Approved Spare Parts Requisitions")
                        {
                            ApplicationArea = All;
                            Image = Approvals;
                            Caption = 'Approved Spare Parts Requisitions';
                            RunObject = page "Spare Part Requisition List";
                            RunPageView = where(Status = filter(Released), Archived = filter(false));
                        }
                        action("Consumed Spare Parts Requisitions")
                        {
                            ApplicationArea = All;
                            Image = Approvals;
                            Caption = 'Consumed Spare Parts Requisitions';
                            RunObject = page "Spare Part Requisition List";
                            RunPageView = where(Status = filter(Released),Transferred= const(true));
                            //,Archived = filter(false)
                        }
                        action("Purchased Spare Parts Requisitions")
                        {
                            ApplicationArea = All;
                            Image = Approvals;
                            Caption = 'Purchased Spare Parts Requisitions';
                            RunObject = page "Spare Part Requisition List";
                            RunPageView = where(Status = filter(Released), "Converted to Quote"= const(true));
                        }
                        action("Rejected Spare Parts Requisitions")
                        {
                            ApplicationArea = All;
                            Caption = 'Rejected Spare Parts Requisitions';
                            RunObject = page "Spare Part Requisition List";
                            RunPageView = where(Status = filter(Rejected), Archived = filter(false));
                            Image = List;
                        }
                        action("All Spare Parts Requisitions")
                        {
                            ApplicationArea = All;
                            Image = Approvals;
                            Caption = 'All Spare Parts Requisitions';
                            RunObject = page "All Spare Part Requisitions";
                        }
                    }
                    group(Archives12)
                    {
                        Caption = 'Archives';
                        action("Spare Parts List Archives")
                        {
                            ApplicationArea = All;
                            Caption = 'Spare Parts Requisition List Archives';
                            Image = Archive;
                            RunObject = page "All Spare Part Requisitions";
                            RunPageView = where(Status = filter(Released), Archived = filter(true));
                        }
                    }
                    group(JournalsStr)
                    {
                        Caption = 'Journals';
                        action(ItemJournalsSpr)
                        {
                            ApplicationArea = All;
                            Caption = 'Item Journals';
                            Image = Journals;
                            RunObject = page "Item Journal Batches";
                            RunPageView = where("Journal Template Name" = const('ITEM'));
                        }
                    }
                }

                group("General Requisitions")
                {
                    group(Lists)
                    {
                        Caption = 'Lists';
                        action("General Requisition List")
                        {
                            ApplicationArea = All;
                            Caption = 'General Requisitions';
                            RunObject = page "General Requisition List";
                            RunPageView = where(Status = filter(Open | "Pending Approval" | "Pending Prepayment"), Archived = filter(false));
                            Image = List;
                        }
                        action("Pending General Requisition")
                        {
                            ApplicationArea = All;
                            Caption = 'Pending General Requisitions';
                            RunObject = page "General Requisition List";
                            RunPageView = where(Status = filter("Pending Approval" | "Pending Prepayment"), Archived = filter(false));
                            Image = List;
                        }
                        action("Approved General Requisitions")
                        {
                            ApplicationArea = All;
                            Image = Approvals;
                            Caption = 'Approved general Requisitions';
                            RunObject = page "General Requisition List";
                            RunPageView = where(Status = filter(Released), Archived = filter(false));
                        }
                        action("All General Requisitions")
                        {
                            ApplicationArea = All;
                            Image = Approvals;
                            Caption = 'All General Requisitions';
                            RunObject = page "All General Requisitions";
                        }
                    }
                    group(Archives)
                    {
                        Caption = 'Archives';
                        action("General List Archives")
                        {
                            ApplicationArea = All;
                            Caption = 'General Requisition List Archives';
                            Image = Archive;
                            RunObject = page "All General Requisitions";
                            RunPageView = where(Status = filter(Released), Archived = filter(true));
                        }
                    }
                    group(JournalsGR)
                    {
                        Caption = 'Journals';
                        action(ItemJournalsGR)
                        {
                            ApplicationArea = All;
                            Caption = 'Item Journals';
                            Image = Journals;
                            RunObject = page "Item Journal Batches";
                            RunPageView = where("Journal Template Name" = const('ITEM'));
                        }
                    }
                }
            }
            group("Cash Purchases")
            {   
                //Caption= 'Cash Purchases'
                action("Open Cash Purchases")
                {
                    Caption = 'Open';
                    Image = List;
                    RunObject = Page "Cash Purchase List";
                    RunPageView = where(Status = const(Open));

                }
                action("Pending Cash Purchases")
                {
                    Caption = 'Pending';
                    Image = List;
                    RunObject = Page "Cash Purchase List";
                    RunPageView = where(Status = const("Pending Approval"));

                }
                action("Approved Cash Purchases")
                {
                    Caption = 'Approved';
                    Image = List;
                    RunObject = Page "Cash Purchase List";
                    RunPageView = where(Status = const("Released"), Posted = const(false));

                }
                action("Posted Cash Purchases")
                {
                    Caption = 'Posted';
                    Image = List;
                    RunObject = Page "Cash Purchase List";
                    RunPageView = where(Posted = const(true));

                }
                action("Rejected Cash Purchases")
                {
                    Caption = 'Rejected';
                    Image = List;
                    RunObject = Page "Cash Purchase List";
                    RunPageView = where(Status = const("Rejected"));

                }
            }
            group("Maintenance Management")
            {
                group(MaintenanceReq)
                {
                    Caption = 'Maintenance Requests';
                    action("MaintenanceRequestSection")
                    {
                        Caption = 'Open Maintenance Requests';
                        Image = List;
                        RunObject = Page "Maintenance Requests";
                        RunPageView = where(Status = filter(Open));
                    }
                    action("Pending Maintenance Requests")
                    {
                        ApplicationArea = All;
                        Caption = 'Pending maintenance Requests';
                        RunObject = page "Maintenance Requests";
                        RunPageView = where(Status = filter("Pending Approval" | "Pending Prepayment"));
                        Image = List;
                    }
                    action("Approved Maintenance Requests")
                    {
                        ApplicationArea = All;
                        Image = Approvals;
                        Caption = 'Approved Maintenance Requests';
                        RunObject = page "Maintenance Requests";
                        RunPageView = where(Status = filter(Released));
                    }
                    action("Rejected Maintenance Requests")
                    {
                        ApplicationArea = All;
                        Image = Approvals;
                        Caption = 'Rejected Maintenance Requests';
                        RunObject = page "Maintenance Requests";
                        RunPageView = where(Status = filter(Rejected));
                    }
                    action("All Maintenance Requests")
                    {
                        ApplicationArea = All;
                        Image = Approvals;
                        Caption = 'All Maintenance Requests';
                        RunObject = page "All Maintenance Requests";
                    }
                }

                group(MaintenanceJobs)
                {
                    Caption = 'Maintenance Jobs';
                    action("MaintenanceJobSection")
                    {
                        Caption = 'New Maintenance Jobs';
                        Image = List;
                        RunObject = Page "Maintenance Job Cards";
                        RunPageView = where("Job Status" = filter(New));
                    }
                    action(MaintenanceJobInProgress)
                    {
                        ApplicationArea = All;
                        Caption = 'Maintenance Jobs In Progress';
                        RunObject = page "Maintenance Job Cards";
                        RunPageView = where("Job Status" = filter("In Progress"));
                        Image = List;
                    }
                    action(MaintenanceJobClosed)
                    {
                        ApplicationArea = All;
                        Image = Approvals;
                        Caption = 'Closed Maintenance Jobs';
                        RunObject = page "Maintenance Job Cards";
                        RunPageView = where("Job Status" = filter(Closed));
                    }
                    action(MaintenanceJobCancelled)
                    {
                        ApplicationArea = All;
                        Image = Approvals;
                        Caption = 'Cancelled Maintenance Jobs';
                        RunObject = page "Maintenance Job Cards";
                        RunPageView = where("Job Status" = filter(Cancelled));
                    }
                    action("All Maintenance Jobs")
                    {
                        ApplicationArea = All;
                        Image = Approvals;
                        Caption = 'All Maintenance Jobs';
                        RunObject = page "All Maintenance Job Cards";
                    }
                }
            }
            group(Setup)
            {
                action("FleetManagementSetup")
                {
                    Caption = 'Fleet Management Setup';
                    Image = Setup;
                    RunObject = Page "Fleet Management Setup";
                }
            }
        }
        area(Embedding)
        {
            action(EmployeeListEmbedded)
            {
                Caption = 'Drivers';
                Image = List;
                RunObject = Page "Driver List";
            }
            action(EquipmentList)
            {
                Caption = 'Equipments';
                Image = List;
                RunObject = Page "Fixed Asset List";
            }
            action(EquipmentTypesEmbedded)
            {
                Caption = 'Equipment Types';
                Image = List;
                RunObject = Page "Equipment Types";
            }
            action(FuelRequisitions)
            {
                Caption = 'Consumptions';
                Image = List;
                RunObject = Page "All Fuel Requisitions";
            }
            action(SparePartsRequisition)
            {
                Caption = 'Spare Parts Requisitions';
                Image = List;
                RunObject = Page "All Spare Part Requisitions";
            }
            action(GeneralRequisition)
            {
                Caption = 'General Requisitions';
                Image = List;
                RunObject = Page "All General Requisitions";
            }
            action(CashPurchases)
            {
                Caption = 'Cash Purchases';
                Image = List;
                RunObject = Page "Cash Purchase List";
            }
            
            action(Checklists)
            {
                Caption = 'Checklists';
                Image = List;
                RunObject = Page "Inspection Checklists";

                

            }
            action(MaintenanceRequests)
            {
                Caption = 'Maintenance Requests';
                Image = List;
                RunObject = Page "All Maintenance Requests";
            }
            action(MaintenanceJobCards)
            {
                Caption = 'Maintenance Jobs';
                Image = List;
                RunObject = Page "All Maintenance Job Cards";
            }
           
            action(ItemSources)
            {
                Caption = 'Item Sources';
                Image = List;
                RunObject = Page "Item Sources";
            }
            action(DailyDriverAssignments)
            {
                Caption = 'Daily Driver Assignments';
                Image = List;
                RunObject = Page DailyDriverOperatorAssignments;
            }
            action(Incidents)
            {
                Caption = 'Incident Forms';
                Image = List;
                RunObject = Page "Incident Forms";
            }
            action(VehicleMovementLogs)
            {
                Caption = 'Vehicle Movement Logs';
                Image = List;
                RunObject = Page "Vehicle Movement Logs";
            }
            
            
            action(CrewLocations)
            {
                Caption = 'Crew Locations';
                Image = List;
                RunObject = Page "Crew Locations";
            }
            action(EmployeeType)
            {
                Caption = 'Employee Types';
                Image = List;
                RunObject = Page "Employee Types";
            }
            action(RoutineMaintenanceTrackers)
            {
                Caption = 'Routine Maintenance Trackers';
                Image = List;
                RunObject = Page "Routine Maintenance Trackers";
            }
            action(StockAtHand)
            {
                Caption = 'Stock at Hand';
                Image = List;
                RunObject = Report "Stock At Hand Report";
            }
            action(StockMovt)
            {
                Caption = 'Stock Movement';
                Image = List;
                RunObject = Report "Stock Movement Report";
            }

        }
    }
}